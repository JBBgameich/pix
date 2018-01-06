import QtQuick 2.9
import QtQuick.Controls 2.2

import "widgets"

ApplicationWindow
{
    id: root
    visible: true
    width: 400
    height: 500
    title: qsTr("Pixs")

    property int currentView : 0


    footer: PixsBar
    {
        id: toolBar
        visible: true
        size: 24

        currentIndex: currentView

        onGalleryViewClicked: currentView = 0
        onAlbumsViewClicked: currentView = 1
        onTagsViewClicked: currentView = 2
        onSettingsViewClicked: currentView = 3
    }

    StackView
    {
        id: stackView
        anchors.fill: parent
        initialItem: SwipeView
        {
            id: swipeView
            width: parent.width
            height: parent.height

            currentIndex: currentView

            onCurrentIndexChanged:
            {
                currentView = currentIndex
            }

            GalleryView
            {

            }

            AlbumsView
            {

            }

            TagsView
            {

            }

            SettingsView
            {

            }


        }

        Component
        {
            id: viewer
            PixsViewer
            {

            }
        }
    }
}
