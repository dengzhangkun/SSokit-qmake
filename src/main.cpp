//
// Created by 冉高飞 on 2019-02-20.
//

#include <QQmlApplicationEngine>
#include <QWindow>
#include <QApplication>
#include <QTranslator>

#include "bluetoothmodel.h"
#include "logmodel.h"
#include "TcpServerModel.h"
#include "UdpServerModel.h"
#include "notepadmodel.h"
#include "TcpClientModel.h"
#include "UdpClientModel.h"

/**
 * 程序入口
 */
int main(int argc, char *argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    QTranslator traslator;           //创建翻译器
    traslator.load("SSokit_zh.qm");    //加载语言包
    app.installTranslator(&traslator); //安装翻译器

    qmlRegisterType<NotepadModel>("src.notepadmodel", 1, 0, "NotepadModel");
    qmlRegisterType<BlueToothModel>("src.bluetoothmodel", 1, 0, "BlueToothModel");
    qmlRegisterType<TcpServerModel>("src.tcpservermodel", 1, 0, "TcpServerModel");
    qmlRegisterType<UdpServerModel>("src.udpservermodel", 1, 0, "UdpServerModel");
    qmlRegisterType<TcpClientModel>("src.tcpclientmodel", 1, 0, "TcpClientModel");
    qmlRegisterType<UdpClientModel>("src.udpclientmodel", 1, 0, "UdpClientModel");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/views/ssokit.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return QApplication::exec();
}
