import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'startPage.dart';

class ScreenB extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScreenB'),
      ),

      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.extended(
                  onPressed: (){
                    Get.offAll(ScreenA());

                  }, label: Text('처음으로'))
            ],
          )
      ),
    );
  }
}
