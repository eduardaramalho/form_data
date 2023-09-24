import 'package:flutter/material.dart';
import 'package:to_do_list/app/theme.dart';
import 'package:to_do_list/pages/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ToDoListTheme.theme,
      title: 'To-do List',
    );
  }
}
