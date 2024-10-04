export default () => {
  const date = Variable("", {
    poll: [1000, 'date "+%a %e %b, %H:%M:%S"'],
  });

  return Widget.Box({
    vertical: true,
    children: [
      Widget.Label({
        class_name: "clock",
        label: date.bind(),
      }),
    ],
  });
};
