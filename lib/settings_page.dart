import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  Function setHejterMode;
  bool hejterCheck = false;
  bool tenaCheck = false;
  SettingsPage(
      {Key? key, required this.setHejterMode, required this.hejterCheck})
      : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _setHejterCheck() {
    widget.setHejterMode(!widget.hejterCheck);
    setState(() {
      widget.hejterCheck = !widget.hejterCheck;
    });
  }

  void _setTenaCheck() {
    setState(() {
      widget.tenaCheck = !widget.tenaCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KinoApp Settings'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: widget.hejterCheck,
                onChanged: (e) => _setHejterCheck(),
              ),
              Text('Hejter mode'),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: widget.tenaCheck,
                onChanged: (e) => _setTenaCheck(),
              ),
              Text('Tena mode'),
            ],
          ),
        ],
      ),
    );
  }
}
