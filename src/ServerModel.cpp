//
// Created by saka on 2019-02-22.
//

#include <QNetworkInterface>
#include "ServerModel.h"
#include "toolkit.h"

ServerModel::ServerModel(QObject *parent) : QObject(parent) {


}

ServerModel::~ServerModel() = default;


void ServerModel::initConfig() {

}

void ServerModel::saveConfig() {

}


void ServerModel::kill(QStringList &list) {

}


void ServerModel::getAddr() {
    QList<QHostAddress> lst = QNetworkInterface::allAddresses();
            foreach (QHostAddress a, lst) {
            if (QAbstractSocket::IPv4Protocol == a.protocol()) {
                emit appendLocalAddr(a.toString());
            }
        }
}

void ServerModel::toggleConnect(bool checked, QString addr, QString port) {

    auto r_port = quint16(port.toUInt());
    if (checked) {
        m_conns.clear();
        openServer(addr, r_port);
    } else {
        closeServer();
    }
}

bool ServerModel::closeServer() {
    OBJMAP::const_iterator i;
    for (i = m_conns.constBegin(); i != m_conns.constEnd(); ++i)
    {
        QString k = i.key();
        void* v = i.value();

        if (close(v))
                emit connClose(k);
    }

    m_conns.clear();
    close();
    emit sendErrMsg(CLOSE_ERR,"Close Server",false);
    return true;
}

void ServerModel::getKeys(QStringList &res) {
    res = m_conns.keys();
}

void ServerModel::setCookie(const QString &k, void *v) {
    void *o = m_conns.value(k);
    if (o) {
        if (close(o))
                emit connClose(k);
    }
    m_conns.insert(k, v);
    emit appendConnAddr(k);
}

void ServerModel::unsetCookie(const QString &k) {
    m_conns.remove(k);
    emit connClose(k);
}

void *ServerModel::getCookie(const QString &k) {
    return m_conns.value(k);
}

void ServerModel::dumpLogMsg(bool rev, QString &host, const char *buf, qint64 length) {
    qDebug() << "dumpLogMsg";
    QString lab(QTime::currentTime().toString("HH:mm:ss.zzz "));
    QString ascData = TK::bin2ascii(buf, length);
    QString hexData = TK::bin2hex(buf, length);
    emit sendLogMsg(lab, rev, host, ascData, hexData, length);

}

void ServerModel::kill(const QString &key) {
    void *v = m_conns.value(key);
    if (v) {
        if (close(v))
            unsetCookie(key);
    } else {
        unsetCookie(key);
    }
}

void ServerModel::send(const QString &key, const QString &data) {
    void *v = m_conns.value(key);
    if (v) {
        QString err;
        QByteArray bin;

        if (!TK::ascii2bin(data, bin, err))
            qDebug() << ("bad data format to send: " + err);
        else
            sendToDst(v, bin);
    }
}




