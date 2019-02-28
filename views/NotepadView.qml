import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

import src.notepadmodel 1.0


ColumnLayout{
    Rectangle{
        id: rectangle
        Layout.fillWidth:true
        Layout.preferredHeight: title.height
            Text {
            id:title
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Notepad")
            font.bold:true
        }
    }
    Rectangle {
        Layout.fillHeight:true
        Layout.fillWidth: true
        NotepadModel{
            id:view
        }

        TextArea{
            focus: true
            width: parent.width-10
            height: parent.height-10
        }
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#ffffff" }
            GradientStop { position: 1.0; color: "#cfd8dc" }
        }
    }
}
