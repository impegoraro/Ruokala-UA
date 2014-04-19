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
        query: "/result/menus/menu[@canteen='" + appEmentas.canteen + "' and @meal='"  + appEmentas.type + "' and @date='Tue, 22 Apr 2014 00:00:00 +0100']/items/item"

        XmlRole { name: "name"; query: "@name/string()" }
        XmlRole { name: "desc"; query: "string()" }

        onXmlChanged: console.log("XML Changed")
        onProgressChanged: console.log("Progess Changed")
    }

    SilicaFlickable {
        id: listFoods
        anchors.fill: parent
        contentHeight: innCol.height

        PullDownMenu {
            MenuItem {
                text: qsTr("Almoço")
                onClicked: { myHeader.title = "Almoço";
                    appEmentas.type = "Almoço"
                    xml_Data.query = "/result/menus/menu[@canteen='" + appEmentas.canteen + "' and @meal='"  + appEmentas.type + "' and @date='Tue, 22 Apr 2014 00:00:00 +0100']/items/item"
                }
            }
            MenuItem {
                text: qsTr("Jantar")
                onClicked: { myHeader.title = "Jantar";
                    appEmentas.type = "Jantar"
                    xml_Data.query = "/result/menus/menu[@canteen='" + appEmentas.canteen + "' and @meal='"  + appEmentas.type + "' and @date='Tue, 22 Apr 2014 00:00:00 +0100']/items/item"
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
            Label {
                id: lblCanteen
                x: Theme.paddingExtraLarge;
                color: Theme.highlightColor
                text: appEmentas.canteen
                anchors.left: parent.left
                anchors.right: parent.right
            }

            SilicaListView {
                id: listView1
                property Item contextMenu
                //height: page.height
                width: page.width
                property bool menuOpen: contextMenu != null && contextMenu.parent === myListItem
                height: menuOpen ? contextMenu.height + contentItem.height : contentItem.height
                //model: myModel
                model: xml_Data
                anchors {
                    left: parent.left
                    right: parent.right
                    margins: Theme.paddingLarge
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
                                y: Theme.paddingLarge
                                text : desc
                                color: Theme.highlightColor
                                //wrapMode: Text.WordWrap
                                truncationMode: TruncationMode.Fade
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





