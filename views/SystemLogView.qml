import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5

ColumnLayout {
    width:parent.width
    height:200
    Component {
           id: contactDelegate
           Item {
               width: 180; height: 40
               Column {
                   Text { text: '<b>Name:</b> ' + name }
                   Text { text: '<b>Number:</b> ' + number }
               }
           }
       }

       ListView {

           model: ListModel {
               ListElement {
                   name: "Bill Smith"
                   number: "555 3264"
               }
               ListElement {
                   name: "John Brown"
                   number: "555 8426"
               }
               ListElement {
                   name: "Sam Wise"
                   number: "555 0473"
               }
           }
           delegate: contactDelegate
           highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
           focus: true
       }
    Button{
        text: qsTr("清除")
    }

}
