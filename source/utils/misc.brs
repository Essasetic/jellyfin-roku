function isNodeEvent(msg, field as string) as boolean
  return type(msg) = "roSGNodeEvent" and msg.getField() = field
end function

function getMsgSubnode(msg, subnode="" as string) as object
  node = msg.getRoSGNode()
  ' Subnode allows for handling alias messages
  if subnode <> ""
    node = node.findNode(subnode)
  end if
  coords = node.rowItemSelected
  target = node.content.getChild(coords[0]).getChild(coords[1])
  return target
end function

sub themeScene()
  ' Takes a scene and applies a consisten UI Theme
  m.scene.backgroundColor = "#101010"
  m.scene.backgroundURI = ""

  m.scene.insertChild(m.overhang, 0)
end sub

function leftPad(base as string, fill as string, length as integer) as string
  while len(base) < length
    base = fill + base
  end while
  return base
end function

function make_dialog(message="" as string)
  ' Takes a string and returns an object for dialog popup
  dialog = createObject("roSGNode", "Dialog")
  dialog.id = "popup"
  dialog.buttons = ["OK"]
  dialog.message = message

  return dialog
end function
