import 'package:flutter/material.dart';

class Display extends StatelessWidget {
  String Data;
  Display(this.Data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetched Data'),
      ),
      body: Center(
        child: Container(
          child: Text(Data),
        ),
      ),
    );
  }
}
