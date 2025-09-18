import 'package:flutter/material.dart';
import 'services/hive_service.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String theme = HiveService.getTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de Tareas',
      theme: theme == "dark" ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(),
    );
  }
}
