import 'package:flutter/material.dart';

class ScreenD extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScreenD'),

      ),
      body: Center(
        child: Text('ScreenD',
          style: TextStyle(
              fontSize: 24.0
          ),
        ),
      ),
    );
  }
}
