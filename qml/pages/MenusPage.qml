/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import QtQuick.XmlListModel 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    XmlListModel {
        id: xml_Data
        source: "http://services.web.ua.pt/sas/ementas?date=week"
        // Qt.formatDateTime(cdate, "ddd, dd MMM yyyy")
        query: "/result/menus/menu[@canteen='" + appEmentas.canteen + "' and @meal='"  + appEmentas.type + "' and @date='" + Qt.formatDateTime(cdate, "ddd, dd MMM yyyy") + " 00:00:00 +0100" +"']/items/item"

        XmlRole { name: "name"; query: "@name/string()" }
        XmlRole { name: "desc"; query: "string()" }

        onXmlChanged: console.log("XML Changed")
    }

    SilicaFlickable {
        id: listFoods
        anchors.fill: parent
        contentHeight: innCol.height

        PushUpMenu {
            MenuItem {
                text: qsTr("Dia Seguinte")
                onClicked: {
                    var day = parseInt(Qt.formatDateTime(cdate, "dd")) + 1
                    var year = parseInt(Qt.formatDateTime(cdate, "yyyy"))
                    var month = parseInt(Qt.formatDateTime(cdate, "MM")) - 1 // Seemed to obtain the next month

                    console.log (day + "/" + month + "/" + year)

                    cdate = new Date(year, month, day)

                    xml_Data.query = "/result/menus/menu[@canteen='" + appEmentas.canteen + "' and @meal='"  + appEmentas.type + "' and @date='" + Qt.formatDateTime(cdate, "ddd, dd MMM yyyy") + " 00:00:00 +0100" +"']/items/item"
                    console.log(xml_Data.query)
                }
            }
            MenuItem {
                text: qsTr("Dia Anterior")
                onClicked: {
                    var day = parseInt(Qt.formatDateTime(cdate, "dd")) - 1
                    var year = parseInt(Qt.formatDateTime(cdate, "yyyy"))
                    var month = parseInt(Qt.formatDateTime(cdate, "MM")) - 1 // Seemed to obtain the next month

                    console.log (day + "/" + month + "/" + year)

                    cdate = new Date(year, month, day)

                    xml_Data.query = "/result/menus/menu[@canteen='" + appEmentas.canteen + "' and @meal='"  + appEmentas.type + "' and @date='" + Qt.formatDateTime(cdate, "ddd, dd MMM yyyy") + " 00:00:00 +0100" +"']/items/item"
                    console.log(xml_Data.query)
                }
            }

            MenuItem {
                text: qsTr("Escolher data")
                //onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
                onClicked: {
                     var page = Qt.resolvedUrl("PickDate.qml")
                     pageStack.push(page)

                }
            }
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Almoço")
                onClicked: {
                    appEmentas.type = "Almoço"
                    var strDate = Qt.formatDateTime(cdate, "ddd, dd MMM yyyy") + " 00:00:00 +0100";
                    xml_Data.query = "/result/menus/menu[@canteen='" + appEmentas.canteen + "' and @meal='"  + appEmentas.type + "' and @date='" + Qt.formatDateTime(cdate, "ddd, dd MMM yyyy") + " 00:00:00 +0100" +"']/items/item"

                }
            }
            MenuItem {
                text: qsTr("Jantar")
                onClicked: {
                    appEmentas.type = "Jantar"
                    var strDate = Qt.formatDateTime(cdate, "ddd, dd MMM yyyy") + " 00:00:00 +0100";
                    xml_Data.query = "/result/menus/menu[@canteen='" + appEmentas.canteen + "' and @meal='"  + appEmentas.type + "' and @date='" + Qt.formatDateTime(cdate, "ddd, dd MMM yyyy") + " 00:00:00 +0100" +"']/items/item"
                }
            }
            MenuItem {
                text: qsTr("Refrescar")
                onClicked: xml_Data.reload()
            }
        }

        Column {
            id: innCol
            width: parent.width
            height: height.width
            spacing: 20

            PageHeader { id: myHeader; title: qsTr(canteen)  }
            Row {
                spacing: parent.width - lblDate.width - 135
                id: rowTitle
                x: Theme.paddingLarge
                width: page.width
                Label {
                    id: lblType

                    x: Theme.paddingLarge
                    color: Theme.secondaryHighlightColor
                    font.pixelSize: Theme.fontSizeSmall
                    text: appEmentas.type
                }
                Label {
                    id: lblDate

                    font.pixelSize: Theme.fontSizeSmall
                    text: Qt.formatDateTime(cdate, "ddd, dd MMM yyyy")
                    color: Theme.secondaryHighlightColor
                    horizontalAlignment: Text.AlignRight
                    //color: highlighted ? theme.highlightColor : theme.primaryColor
                }
                /*ComboBox {
                    id: lblDate
                    currentIndex: 1
                    label: "Data"
                    menu: ContextMenu {
                        MenuItem { text: Qt.formatDateTime(cdate, "ddd, dd MMM yyyy") }
                        MenuItem { text: "Amanhã" }
                        MenuItem { text: "Escolher data..." }
                    }
                }*/
            }

            SilicaListView {
                id: listView1
                //height: page.height
                width: page.width
                property Item contextMenu
                property bool menuOpen: contextMenu != null && contextMenu.parent === myListItem
                height: menuOpen ? contextMenu.height + contentItem.height : contentItem.height
                model: xml_Data

                anchors {
                    left: parent.left
                    right: parent.right
                }

                delegate: Item {
                    id: myListItem
                    x: Theme.paddingLarge
                    width: ListView.view.width
                    height: Theme.itemSizeSmall

                    Column {
                        id: lvCol
                        width: parent.width
                        height: parent.height
                        Text {
                            y: Theme.paddingSmall
                            text : name;
                            color: Theme.secondaryHighlightColor
                            fontSizeMode: Theme.fontSizeSmall
                        }
                        /*BackgroundItem {
                            id: contentItem
                            width: lblDescrip.width
                            x: Theme.paddingLarge
                            y: Theme.paddingLarge*/

                            Label {
                                id: lblDescrip
                                //y: Theme.paddingLarge
                                width: parent.width
                                text : desc
                                color: Theme.highlightColor
                                wrapMode: Text.WordWrap
                                //truncationMode: TruncationMode.Fade

                                anchors {
                                    left: parent.left
                                    right: parent.right
                                    margins: Theme.paddingLarge
                                }
                            }
                            /*onPressAndHold: {
                                if(!contextMenu)
                                    contextMenu = contextMenuComponent.createObject(listView)
                                contextMenu.show(myListItem)
                            }
                        }*/
                    }
                }

            }
            Label {
                x: Theme.paddingLarge
                id: lblClosed1
                visible: xml_Data.count == 0
                width: parent.width
                //horizontalAlignment: HorizontalAlignment.Center
                //verticalAlignment: VerticalAlignment.Center
                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeLarge

                color: Theme.highlightColor
                text: qsTr("Encerrado")

            }
            Label {
                id: lblClosed2
                y: Theme.paddingSmall
                x: Theme.paddingLarge
                visible: xml_Data.count == 0
                width: lblClosed1.width
                //horizontalAlignment: HorizontalAlignment.Center
                //verticalAlignment: VerticalAlignment.Center
                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeMedium

                color: Theme.secondaryHighlightColor
                text: qsTr("Não seram servidas refeições nesta cantina")

            }


        }
        Component {
            id: contextMenuComponent
            ContextMenu {
                MenuItem {
                    text: "Partilhar"
                    onClicked: console.log(qsTr("Partilhado"))
                }
                MenuItem {
                    text: "Copiar"
                    onClicked: console.log(qsTr("Copiado"))
                }
            }
        }
    }
}





