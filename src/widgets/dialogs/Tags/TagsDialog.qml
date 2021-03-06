import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import "../../../view_models"
import "../../../db/Query.js" as Q
import "../../views/Pix.js" as PIX
import org.kde.maui 1.0 as Maui

PixDialog
{
    property string picUrl : ""
    property bool forAlbum : false
    clip: true
    signal albumTagged(string tag, string url)
    signal picTagged(string tag, string url)
    signal tagsAdded(var tags, string url)


    standardButtons: Dialog.Save | Dialog.Cancel

    onAccepted: setTags()
    onRejected: close()
    onOpened: populate()


    ColumnLayout
    {
        anchors.fill: parent

        TagsList
        {
            id: tagsList
            Layout.fillHeight: true
            Layout.fillWidth: true
            width: parent.width
            height: parent.height

            onTagClicked:
            {
                tagListComposer.model.insert(0, {tag: tagsList.model.get(index).tag})
            }
        }

        TextField
        {
            id: tagText
            Layout.fillWidth: true
            Layout.leftMargin: contentMargins
            Layout.rightMargin: contentMargins
            placeholderText: "Tags..."
            onAccepted:
            {
                var tags = tagText.text.split(",")
                for(var i in tags)
                {
                    var myTag = tags[i].trim()
                    if(!tag.tagExists(myTag, true))
                        tagsList.model.insert(0, {tag: myTag})

                    tagListComposer.model.insert(0, {tag: myTag})

                }
                clear()
            }
        }


        Maui.TagList
        {
            id: tagListComposer
            Layout.fillWidth: true
            Layout.leftMargin: contentMargins
            Layout.rightMargin: contentMargins

            height: 64
            width: parent.width
            onTagRemoved:
            {
                pix.removePicTag(model.get(index).tag, pixViewer.currentPic.url)
                tagListComposer.model.remove(index)
            }
        }
    }

    function show(url)
    {
        picUrl = url
        open()
    }

    function setTags()
    {
        var tags = []

        for(var i = 0; i < tagListComposer.model.count; i++)
            tags.push(tagListComposer.model.get(i))

        tagsAdded(tags, picUrl)
    }

    function addTagsToPic(url, tags)
    {
        if(tags.length > 0)
        {
            if(!pix.checkExistance("images", "url", url))
                if(!pix.addPic(url))
                    return

            for(var i in tags)
                if(PIX.addTagToPic(tags[i].tag, url))
                    picTagged(tags[i].tag, url)
        }

        close()
    }

    function addTagsToAlbum(url, tags)
    {
        if(tags.length > 0)
            for(var i in tags)
            {
                if(PIX.addTagToAlbum(tags[i].tag, url))
                    albumTagged(tags[i].tag, picUrl)
            }

        close()
    }

    function populate()
    {
        tagsList.model.clear()
        var tags = tag.getUrlsTags()

        if(tags.length > 0)
            for(var i in tags)
                tagsList.model.append(tags[i])


        tagListComposer.populate(forAlbum ? tag.getAbstractTags("album", picUrl, true) :
                                            tag.getUrlTags(picUrl, true))
    }
}
