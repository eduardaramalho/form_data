import 'package:flutter/material.dart';

class AppListTile extends StatefulWidget {
  final String title;
  const AppListTile({super.key, required this.title});

  @override
  State<AppListTile> createState() => _AppListTileState();
}

class _AppListTileState extends State<AppListTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: false,
      onChanged: (bool? value) {},
    );
  }
}
