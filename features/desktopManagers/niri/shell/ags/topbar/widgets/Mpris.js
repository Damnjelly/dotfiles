const mpris = await Service.import("mpris");

/** @param {import('types/service/mpris').MprisPlayer} player */
const Player = (player) =>
  Widget.Button({
		css: "margin: 0 8px 0 8px;",
    onClicked: () => player.playPause(),
    child: Widget.Label().hook(player, (label) => {
      const { track_artists, track_title } = player;
      label.label = `${track_artists.join(", ")} - ${track_title}`;
    }),
  });

const players = Widget.Box({
  children: mpris.bind("players").as((p) => p.map(Player)),
});

export default () => {
  return Widget.Box({
    class_name: "mpris",
    children: [players],
  });
};
