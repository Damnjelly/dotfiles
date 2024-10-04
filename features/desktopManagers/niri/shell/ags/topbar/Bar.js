import Clock from "./widgets/Clock.js"
import Mpris from "./widgets/Mpris.js"

// layout of the bar
function Start() {
  return Widget.Box({
    vpack: "center",
    hpack: "start",
    spacing: 8,
		children: [Clock()],
  });
}

function End() {
  return Widget.Box({
		css: "padding-right: 60px;",
    vpack: "center",
    hpack: "end",
    spacing: 8,
		children: [Mpris()],
  });
}

export default (monitor = 0) =>
  Widget.Window({
		css: "background-color: transparent;",
    name: "topbar${monitor}",
    anchor: ["left", "top", "right"],
    keymode: "on-demand",
    layer: "top",
    margins: [4, 8, 8, 8],
    monitor,
    child: Widget.CenterBox({
      start_widget: Start(),
      end_widget: End(),
    }),
  });
