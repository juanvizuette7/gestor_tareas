import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String settingsBox = "settings";

  static Future init() async {
    await Hive.initFlutter();
    await Hive.openBox(settingsBox);
  }

  static Box get box => Hive.box(settingsBox);

  static void setTheme(String theme) => box.put("theme", theme);
  static String getTheme() => box.get("theme", defaultValue: "light");

  static void setNotifications(bool enabled) =>
      box.put("notifications", enabled);
  static bool getNotifications() =>
      box.get("notifications", defaultValue: true);

  static void setLastFilter(String filter) => box.put("filter", filter);
  static String getLastFilter() => box.get("filter", defaultValue: "todas");
}
