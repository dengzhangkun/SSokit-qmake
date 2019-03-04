import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12

Column {
    property int viewType: 1 /*1是server,2是client*/
    property var title
    id: column
    width: 250
    height: parent.height

    signal startConnect(bool checked,string addr,string port)
    signal disconnectConn(string addr)
    signal connectState(bool state)
    GroupBox{
        id:groupBox
        width: parent.width
        height: 250
        background: Rectangle{
            color: "#00000000"
            border.color: "#bdbdbd"
            border.width: 1
            radius: 5
        }

        label: Label{
            x: groupBox.leftPadding
            width: groupBox.availableWidth
            text: qsTr(title)
            color: "black"
            font.bold: true
            topPadding: 10
            font.pointSize:18
            elide: Text.ElideRight
        }
        ColumnLayout{
            width:parent.width
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                Label{
                    Layout.preferredWidth: 50
                    text: qsTr("ADDR")
                    font.bold: true
                }
                EditComboBox{
                    id:addrBox
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30
                    editable: viewType===2
                    textRole:"addr"
                    enabled: !toggleConnect.checked
                    model: ListModel{ id:addrListModel }
                }
            }
            Item {
                height: 20
            }
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: 30
                Label{
                    Layout.preferredWidth: 50
                    text:qsTr("PORT")
                    font.bold: true
                }
                EditComboBox{
                    id:portBox
                    Layout.fillWidth: true
                    Layout.preferredHeight: 30
                    editable: true
                    textRole:"port"
                    enabled: !toggleConnect.checked
                    model: ListModel{ id:portListModel
                        ListElement{port:"11000"}
                        ListElement{port:"11001"}
                    }
                    validate: IntValidator{
                        top:65535
                        bottom:0
                    }
                    maxLength:5
                }

            }


            Item {
                height: 20
            }

            Button {
                id: toggleConnect
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                Layout.leftMargin: 20
                Layout.rightMargin: 20
                text: checked?qsTr("Disconnect"):qsTr("Connect")
                checkable: true
                contentItem: Text {
                    text: toggleConnect.text
                    font: toggleConnect.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    color: toggleConnect.checked?"white":"black"
                }

                background: Rectangle {
                    opacity: enabled ? 1 : 0.3
                    border.color:  "#37474f"
                    border.width: 1
                    radius: toggleConnect.width/2
                    color: parent.checked?"#37474f":"#00ffffff"
                }

                onToggled: {
                    if(!isAccectablePort(portBox.getEditText())){
                        toggleConnect.checked=false
                        tip.setState(!toggleConnect.checked,"端口必须是1024-63365之间的数字")
                        return
                    }
                    startConnect(checked,addrBox.editText,portBox.editText)
                    connectState(historyConnect.count>0&&checked)
                }
            }
            Item {
                height:10
            }
            TipLabel{
                id:tip
                Layout.fillWidth: true
                Layout.preferredHeight: 30
            }

        }
    }
    Item{
        height: 20
        width: parent.width
    }

    Component {
        id: contactDelegate
        ItemDelegate {
            width: connectList.width
            height: 50
            Column {
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    x:10
                    verticalAlignment: Text.AlignVCenter
                    height: 20
                    text:addr
                    font.pointSize: 13
                    color:parent.parent.highlighted ? "white" : "black"
                }
                Text {
                    x:15
                    verticalAlignment: Text.AlignVCenter
                    height: 20
                    font.pointSize: 10
                    color:parent.parent.highlighted ? "#cfd8dc" : "#424242"
                    text: "连接时间: "+time }
            }
            background: Rectangle{
                color:highlighted?"#37474f":"#00000000"
                radius: 4
            }
            highlighted: connectList.currentIndex==index
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    connectList.currentIndex=index}
            }
        }
    }


    ListView {
        id:connectList
        visible: true
        width: parent.width
        height: parent.height-320
        clip:true
        model: ListModel {
            id:historyConnect
        }
        delegate: contactDelegate
        focus: true
    }
    Rectangle{
        width: parent.width
        height: 30
        visible: viewType===1
        color: "#00000000"
        Button{
            anchors.centerIn: parent
            width: parent.width*0.5
            height: 30
            text: qsTr("断开")
            background: Rectangle{
                color: "#00000000"
                border.color:"#37474f"
                border.width: 1
                radius: parent.height/2
            }

            onClicked:{
                if(connectList.currentIndex<0){
                    console.log("当前无连接")
                    return
                }
                disconnectConn(historyConnect.get(connectList.currentIndex).addr)
            }
        }
    }
    function isAccectablePort(port){
        if(port>10&&port<65535){
            return true
        }
        return false
    }

    function appendLocalAddr(msg){
        addrListModel.append({addr:msg})
        addrBox.currentIndex=0
    }

    function appendHistoryConnect(msg){
        historyConnect.append({time:(new Date().toLocaleString(Qt.locale("de_DE"),"yyyy-MM-dd hh:mm:ss")),addr:msg})
        connectState(historyConnect.count>0&&toggleConnect.checked)
    }


    function connClose(addr){
        console.log("Server Contorl View close "+addr)
        for(var i=historyConnect.count-1;i>=0;i--){
            if(addr===historyConnect.get(i).addr){
                historyConnect.remove(i)}
        }
        connectState(historyConnect.count>0&&toggleConnect.checked)
    }

    function getCurrentConn(){
        if(!toggleConnect.checked){
            console.log("当前无连接")
            return
        }

        if(connectList.currentIndex<0){
            console.log("index  is smaller than 0")
            return
        }
        return historyConnect.get(connectList.currentIndex).addr
    }

    function setErrMsg(type,msg,isErr){
        if(type===1){
            toggleConnect.checked=!isErr
        }else if(type===2){
            toggleConnect.checked=false
        }
        tip.setState(isErr,msg)
    }

    Component.onDestruction: {
        console.log("ServerControllView onDestruction")
    }
}
