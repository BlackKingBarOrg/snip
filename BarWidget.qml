import QtQuick
import qs.Commons
import qs.Ui

// One click: drag a region on the frozen screen and the PNG lands on the
// clipboard, confirmed by a short toast. Nothing is kept on disk and no
// editor opens. The picking, screen freeze and cursor handling all come from
// Omarchy's own screenshot command (see snip.sh); Esc or a right-click
// cancels the pick.
BarWidget {
  id: root
  moduleName: "ai.bkblab.snip"

  readonly property string script: decodeURIComponent(Qt.resolvedUrl("snip.sh").toString().replace(/^file:\/\//, ""))

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "󰹑"
    slotSize: Style.bar.statusSlot
    tooltipText: "框选截图到剪贴板"
    onPressed: function(b) {
      if (b === Qt.LeftButton && root.bar) root.bar.run(Util.shellQuote(root.script))
    }
  }
}
