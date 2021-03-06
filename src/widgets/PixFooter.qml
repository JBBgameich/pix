import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.maui 1.0 as Maui

import "../widgets/views/Viewer/Viewer.js" as VIEWER

Row
{
    spacing: space.medium
    id: footerToolbar


    Maui.ToolButton
    {
        iconName: "go-previous"
        onClicked: VIEWER.previous()
    }

    Maui.PieButton
    {
        id: favIcon
        iconName: "list-add"

        model: ListModel
        {
            ListElement {iconName: "tag"; btn: "tag"}
            ListElement {iconName: "love"; btn:"love"}
            ListElement {iconName: "image-frames"; btn: "album"}
        }

        onItemClicked:
        {
            if(item.btn === "love")
                pixViewer.currentPicFav = VIEWER.fav(pixViewer.currentPic.url)

            if(item.btn === "tag")
                tagsDialog.show(pixViewer.currentPic.url)

            if(item.btn === "album")
                albumsDialog.show(pixViewer.currentPic.url)
        }
    }

    Maui.ToolButton
    {
        iconName: "go-next"
        onClicked: VIEWER.next()
    }
}
