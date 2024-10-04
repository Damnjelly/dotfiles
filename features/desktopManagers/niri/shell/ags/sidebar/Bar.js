const mpris = await Service.import("mpris");
const audio = await Service.import("audio");
const systemtray = await Service.import("systemtray");
const bluetooth = await Service.import("bluetooth");

function Spacer() {
  return Widget.Box({
    class_name: "spacer",
  });
}

function BarIcon() {
  /** @param {import('types/service/mpris').MprisPlayer} player */
  const Player = (player) =>
    Widget.Box({
      class_name: "baricon",
      css: player.bind("cover_path").transform(
        (p) => `
            background-image: url('${p}'); 
        `,
      ),
    });


  return Widget.Box({
    vertical: true,
    hpack: "center",
    children: mpris.bind("players").transform(
      (p) =>
        p
          .filter((p) =>
            p.bus_name.toLowerCase().includes("amberol", "spotify"),
          )
          .map(Player)
          .entries()
          .next().value,
    ),
  });
}

function Volume() {
  const icons = {
    101: "overamplified",
    67: "high",
    34: "medium",
    1: "low",
    0: "muted",
  };

  function getIcon() {
    const icon = audio.speaker.is_muted
      ? 0
      : [101, 67, 34, 1, 0].find(
          (threshold) => threshold <= audio.speaker.volume * 100,
        );

    return `audio-volume-${icons[icon]}-symbolic`;
  }

  const icon = Widget.Icon({
    class_name: "icon",
    icon: Utils.watch(getIcon(), audio.speaker, getIcon),
  });

  const slider = Widget.LevelBar({
    class_name: "slider",
    vexpand: true,
    vertical: true,
    inverted: true,
    setup: (self) =>
      self.hook(audio.speaker, () => {
        self.value = audio.speaker.volume || 0;
      }),
  });

  return Widget.Box({
    class_name: "volume",
    vertical: true,
    children: [slider, icon],
  });
}

function SysTray() {
  const icon = Widget.Icon({
    class_name: "icon",
    hexpand: true,
    hpack: "end",
    vpack: "start",
  });

  const items = systemtray.bind("items").as((items) =>
    items.map((item) =>
      Widget.Button({
        child: Widget.Icon({ icon: item.bind("icon") }),
        on_primary_click: (_, event) => item.activate(event),
        on_secondary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind("tooltip_markup"),
      }),
    ),
  );

  return Widget.Box({
    vertical: true,
    hpack: "center",
    class_name: "systray",
    children: items,
  });
}

function Clock() {
  const date = Variable("", {
    poll: [1000, 'date "+%H:%M %a %e"'],
  });

  return Widget.Box({
    vertical: true,
    children: [
      Widget.Label({
        class_name: "clock",
        angle: 270,
        label: date.bind(),
      }),
    ],
  });
}

function Bluetooth() {
  return Widget.Box({
    class_name: "bluetooth",
    children: [
      Widget.Button({
        child: Widget.Icon({
          icon: bluetooth
            .bind("enabled")
            .as((on) => `bluetooth-${on ? "active" : "disabled"}-symbolic`),
        }),
        on_primary_click: () =>
          Utils.execAsync([
            "niri",
            "msg",
            "action",
            "spawn",
            "--",
            "foot",
            "bluetuith",
          ]),
      }),
    ],
  });
}

// layout of the bar
function Top() {
  return Widget.Box({
    vpack: "start",
    hpack: "center",
    vertical: true,
    spacing: 8,
    children: [BarIcon(), Spacer(), Bluetooth(), SysTray()],
  });
}

function Bottom() {
  return Widget.Box({
    vpack: "end",
    hpack: "center",
    vertical: true,
    spacing: 8,
    children: [Volume()],
  });
}

export default (monitor = 0) =>
  Widget.Window({
    name: "bottombar${monitor}",
    anchor: ["top", "right", "bottom"],
    keymode: "on-demand",
    layer: "top",
    margins: [8],
    monitor,
    child: Widget.CenterBox({
      class_name: "bar",
      vertical: true,
      start_widget: Top(),
      end_widget: Bottom(),
    }),
  });
