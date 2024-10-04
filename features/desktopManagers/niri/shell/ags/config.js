import TopBar from "./sidebar/Bar.js";
import BottomBar from "./topbar/Bar.js";
import { NotificationPopups } from "./notification/notificationPopups.js";

Utils.timeout(100, () => Utils.notify({
    summary: "Notification Popup Example",
    iconName: "info-symbolic",
    body: "Lorem ipsum dolor sit amet, qui minim labore adipisicing "
        + "minim sint cillum sint consectetur cupidatat.",
    actions: {
        "Cool": () => print("pressed Cool"),
    },
}))

App.config({
  style: "./style.css",
  windows: [TopBar(0), BottomBar(0), NotificationPopups()],
});
