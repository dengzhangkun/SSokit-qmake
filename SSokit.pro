QT += quick
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        src/main.cpp \
#        src/baseform.cpp \
#        src/clientform.cpp \
#        src/clientskt.cpp \
        src/logger.cpp \
#        src/notepadform.cpp \
#        src/serverform.cpp \
#        src/serverskt.cpp \
        src/setting.cpp \
        src/toolkit.cpp \
#        src/transferform.cpp \
#        src/transferskt.cpp \
#        src/sokit.cpp \
        src/notepadmodel.cpp \
        src/ServerModel.cpp \
        src/bluetoothmodel.cpp \
        src/logmodel.cpp \
        src/logtreemodel.cpp \
        src/TcpServerModel.cpp \
        src/UdpServerModel.cpp \
        src/StringListModel.cpp \
        src/ClientModel.cpp \
        src/TcpClientModel.cpp \
        src/UdpClientModel.cpp \

HEADERS +=src/bluetoothmodel.h \
          src/logmodel.h \
          src/TcpServerModel.h \
          src/UdpServerModel.h \
          src/notepadmodel.h \
          src/TcpClientModel.h \
          src/UdpClientModel.h \
          src/ClientModel.h \
          src/ServerModel.h \
          src/Logger.h \
          src/StringListModel.h

RESOURCES += qml.qrc


RC_FILE = sokit.rc

ICON = sokit.ico

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =


QT += widgets \
      bluetooth
# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
