sub init()
    m.top.itemComponentName = "LibItem"
    m.top.content = getData()

    m.top.rowFocusAnimationStyle = "fixedFocusWrap"
    m.top.vertFocusAnimationStyle = "fixedFocusWrap"

    m.top.showRowLabel = [true]
    m.top.rowLabelOffset = [0, 20]
    m.top.showRowCounter = [true]

    updateSize()

    m.top.setfocus(true)
end sub

sub updateSize()
    ' real border is border - rowlist title and rowlist padding
    topborder = 50
    sideborder = 150
    ' 115 is the overhang height
    m.top.translation = [sideborder, topborder + 115]

    itemWidth = 480
    itemHeight = 330

    m.top.visible = true

    ' size of the whole row
    m.top.itemSize = [1920 - sideborder * 2, itemHeight]
    ' spacing between rows
    m.top.itemSpacing = [0, 30]

    ' size of the item in the row
    m.top.rowItemSize = [itemWidth, itemHeight]
    ' spacing between items in a row
    m.top.rowItemSpacing = [20, 0]
end sub

function getData()
    if m.top.libList = invalid then
        data = CreateObject("roSGNode", "ContentNode")
        m.top.content = data
        return data
    end if

    libs = m.top.libList
    data = CreateObject("roSGNode", "ContentNode")

    row = data.CreateChild("ContentNode")
    row.title = "My Media"
    for i = 1 to libs.TotalRecordCount
        item = libs.Items[i - 1]
        row.appendChild(item)
    end for
    m.top.content = data
    return data
end function

function onKeyEvent(key as string, press as boolean) as boolean
    if not press then return false

    ' When hitting down, if unhandled then we are trying to escape downwards
    if key = "down" and (m.top.itemFocused + 1) = m.top.content.getChildCount()
        search = m.top.getScene().findNode("search")
        search.setFocus(true)
        search.findNode("search-input").setFocus(true)
        search.findNode("search-input").active = true
        return true
    else if key = "options"
        options = m.top.getScene().findNode("options")
        list = options.findNode("panelList")

        options.visible = true
        list.setFocus(true)

        return true
    end if

    return false
end function
