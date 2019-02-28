import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import src.udpclientmodel 1.0

Row{
    leftPadding:10
    rightPadding: 10
    UdpClientModel{
        id:udpModel
    }
    spacing:10

    LogView{
        id:udpLog
        w: parent.width-serverControl.width-parent.spacing-parent.rightPadding-parent.leftPadding
        h:parent.height

        onSendMsg:{
            if(!serverControl.getCurrentConn()){
                console.log("UDP Client View : 当前无连接信息,无法发送信息")
                return
            }
            if(!msg){
                console.log("信息无内容")
                return
            }
            console.log("UDP client 发送信息"+msg)
            udpModel.send(msg)
        }
    }

    ServerControlView{
        id:serverControl
        title: qsTr("Controls")
        viewType: 2
        onStartConnect: {
            udpModel.toggleConnect(checked,addr,port)
        }

        onDisconnectConn: {
            udpModel.kill(addr)
        }
        onConnectState: {
            console.log("change state "+state)
            udpLog.setSendMsgState(state)
        }
    }



    function appendLocalAddr(msg){
        serverControl.appendLocalAddr(msg)
    }

    function appendConnec(msg){
        serverControl.appendHistoryConnect(msg)
    }

    function appendLogMsg(time,type,host,ascData,hexData,length){
        console.log("UdpClient:ascData="+ascData)
        udpLog.appendData(time,type,host,ascData,hexData,length)
    }


    function connClose(addr){
        console.log("close connection "+addr)
        serverControl.connClose(addr)
    }

    function setSendErrMsg(type,msg,isErr){
        console.log("error type "+type+"||||"+msg+"||||"+isErr)
        if(type===1||type===2){
            serverControl.setErrMsg(type,msg,isErr)
        }else if(type===3){
            udpLog.setErrMsg(msg)
        }else if(type===4){
            console.log(msg)
        }
    }

    Component.onCompleted: {
        udpModel.appendLocalAddr.connect(appendLocalAddr)
        udpModel.sendLogMsg.connect(appendLogMsg)
        udpModel.appendConnAddr.connect(appendConnec)
        udpModel.connClose.connect(connClose)
        udpModel.sendErrMsg.connect(setSendErrMsg)
        udpModel.getAddr()
    }

    Component.onDestruction: {
        udpModel.appendLocalAddr.disconnect(appendLocalAddr)
        udpModel.sendLogMsg.disconnect(appendLogMsg)
        udpModel.appendConnAddr.disconnect(appendConnec)
        udpModel.connClose.disconnect(connClose)
        udpModel.sendErrMsg.connect(setSendErrMsg)
    }

}
