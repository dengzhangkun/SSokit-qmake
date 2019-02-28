//
// Created by saka on 2019-02-28.
//

#include <QHostAddress>
#include <QNetworkInterface>
#include <QTime>
#include "ClientModel.h"
#include "toolkit.h"

ClientModel::ClientModel(QObject *parent) : QObject(parent) {}

void ClientModel::getAddr() {
    QList<QHostAddress> lst = QNetworkInterface::allAddresses();
            foreach (QHostAddress a, lst) {
            if (QAbstractSocket::IPv4Protocol == a.protocol()) {
                emit appendLocalAddr(a.toString());
            }
        }
}

void ClientModel::toggleConnect(bool checked, QString addr, QString port) {
    auto r_port = quint16(port.toUInt());
    if (checked) {
        openClient(addr, r_port);
    } else {
        closeClient();
    }
}

void ClientModel::kill(const QString &key) {

}

void ClientModel::send(const QString &data) {
    QString err;
    QByteArray bin;

    if (!TK::ascii2bin(data, bin, err)) {
        qDebug() << ("bad data format to send: " + err);
        return;
    }
    qDebug()<<"UDP model send data "<<data;

    sendToDst(bin);
}

bool ClientModel::closeClient() {
    emit connClose(host);
    close();
    return true;
}

void ClientModel::dumpLogMsg(bool rev, QString &host, const char *buf, qint64 length) {
    qDebug() << "dumpLogMsg";
    QString lab(QTime::currentTime().toString("HH:mm:ss.zzz "));
    QString ascData = TK::bin2ascii(buf, length);
    QString hexData = TK::bin2hex(buf, length);
    emit sendLogMsg(lab, rev, host, ascData, hexData, length);
}


