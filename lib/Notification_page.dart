import 'package:flutter/material.dart';
void main() {

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:notification_page(),

    );
  }
}
class notification_page extends StatelessWidget {
  const notification_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
