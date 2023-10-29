import 'package:flutter/material.dart';
import 'package:g_vesion/scrennC.dart';
import 'package:g_vesion/screenD.dart';
import 'package:get/get.dart';

import 'scrennB.dart';

void main() => runApp(ScreenA());

class ScreenA extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            print('menu button is clicked');
          },
        ),
        title: Text('Secnod'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton.extended(
              onPressed: (){
                Get.to(ScreenB());
              },
              label: Text('Go to second'),
            ),
            const SizedBox(height: 10),
            FloatingActionButton.extended(
              onPressed: (){
                Get.to(ScreenC());
              },
              label: Text('go to third'),
            ),
            SizedBox(height: 10,),

            FloatingActionButton.extended(
                onPressed: (){
                  Get.to(ScreenD());

                }, label: Text('go to c'))
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'explore',),
          NavigationDestination(
            icon: Icon(Icons.commute),
            label: 'Commute',),
          NavigationDestination(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',),
        ],
      ),
    );
  }
}

