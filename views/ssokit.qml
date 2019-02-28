import QtQuick.Controls 2.5
import QtQuick 2.12

ApplicationWindow{
    visible: true
    title: qsTr("SSokit -- F1 for help")
    width: 800
    height: 600
    minimumWidth: 800
    minimumHeight:600

    footer: TabBar {
        id: footerBar
        contentWidth:  parent.width
        currentIndex: view.currentIndex
        leftPadding: 50
        rightPadding: 50
        background: Rectangle {
            color: "#37474f"
        }

        BottomButton {
            name:"Tcp"
        }
        BottomButton {
            name:"Udp"
        }
        BottomButton {
            name:"BlueTooth"
        }
//        BottomButton{
//            name:"COM"
//        }
//        BottomButton{
//            id:notepad
//            name:"Notepad"
//        }
        BottomButton{
            id:peltte
            name:"Plette"
        }
    }

    SwipeView{
        id: view
        currentIndex: footerBar.currentIndex
        anchors.fill: parent
        clip: true
        interactive:false
        TcpView{

        }

        UdpView{

        }


        BlueToothView{

        }

//        NotepadView{

//        }
        ColorList{

        }
    }


    HelpDialog{
        id:helpdialog
        showing:false
    }

    Shortcut{
        sequence: "F1"
        context:Qt.ApplicationShortcut
        onActivated: helpdialog.toggleDialog()
    }

    Shortcut{
        sequences: ["shift+tab"]
        context: Qt.ApplicationShortcut
        onActivated: switchTab()
    }
    function switchTab(){
        footerBar.currentIndex++
        footerBar.currentIndex=footerBar.currentIndex % 4
    }

}
