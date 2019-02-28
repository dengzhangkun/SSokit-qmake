import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5

GroupBox{
    property bool canSendMsg: false
    background: Rectangle{radius: 5;color:"#00000000";border.color: "#bdbdbd";border.width: 1}
    signal sendMsg(string msg)
    ColumnLayout{
        width: parent.width
        RowLayout{
            Layout.fillWidth: true
            height: 30
            Label{
                Layout.preferredWidth: 50
                Layout.fillHeight: true
                text: qsTr("Buf1:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            TextField{
                id:butffer1
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: 20
                background: Rectangle {
                    color: butffer1.enabled ? "transparent" : "#00ffffff"
                    border.color: butffer1.enabled ? "#bdbdbd" : "#bdbdbd"
                    radius: 3
                }
            }
            Button{
                enabled: canSendMsg
                Layout.preferredWidth: 50
                Layout.fillHeight:false
                Layout.preferredHeight: 25
                text: qsTr("send")
                background: Rectangle{
                    border.color: enabled?"#37474f":"#cfd8dc"
                    color: "transparent"
                    border.width: 1
                    radius: parent.height/2
                }
                onClicked: sendMsg(butffer1.text)
            }
        }
        RowLayout{
            Layout.fillWidth: true
            height: 30
            Label{
                Layout.preferredWidth: 50
                Layout.fillHeight: true
                text: qsTr("Buf2:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            TextField{
                id:buffer2
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: 20
                background: Rectangle {
                    color: buffer2.enabled ? "transparent" : "transparent"
                    border.color: buffer2.enabled ? "#bdbdbd" : "#bdbdbd"
                    radius: 3
                }
            }
            Button{
                enabled: canSendMsg
                Layout.preferredWidth: 50
                Layout.fillHeight:false
                Layout.preferredHeight: 25
                text: qsTr("send")
                background: Rectangle{
                    border.color: enabled?"#37474f":"#cfd8dc"
                    color: "transparent"
                    border.width: 1
                    radius: parent.height/2
                }
                onClicked: sendMsg(buffer2.text)
            }
        }
        RowLayout{
            Layout.fillWidth: true
            height: 30
            Label{
                Layout.preferredWidth: 50
                Layout.fillHeight: true
                text: qsTr("Buf3:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            TextField{
                id:buffer3
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredHeight: 30
                background: Rectangle {
                    color: buffer3.enabled ? "transparent" : "#00ffffff"
                    border.color: buffer3.enabled ? "#bdbdbd" : "#bdbdbd"
                    radius: 3
                }
            }
            Button{
                enabled: canSendMsg
                Layout.preferredWidth: 50
                Layout.fillHeight:false
                Layout.preferredHeight: 25
                text: qsTr("send")
                background: Rectangle{
                    border.color: enabled?"#37474f":"#cfd8dc"
                    color: "transparent"
                    border.width: 1
                    radius: parent.height/2
                }
                onClicked: sendMsg(buffer3.text)
            }
        }
        RowLayout{
            Layout.fillWidth: true
            height: 20
            TipLabel{
                id:errMsg
                Layout.fillWidth: true
                Layout.fillHeight: true
                msg:""
                err:true
            }
        }
    }
    function setSendMsgState(canSend){
        canSendMsg=canSend
    }

    function setErrorMsg(msg){
        errMsg.setState(true,msg)
    }

}
