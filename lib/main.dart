import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'G-VISION',
      theme: ThemeData(
          useMaterial3: false,
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff4CAF50))),
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'G-VISION',
          ),
        ),
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () {
              print("right bT");
            },
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.add,
                size: 40.0,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: const Color(0xffD3D3D3),
        child: const Center(
          child: Text("프로젝트 목록"),
        ),
      ),




      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list),
              label: '프로젝트 목록'),
          BottomNavigationBarItem(
              icon: Icon(Icons.unarchive),
              label: '공유함'),
        ],
      ),
    );
  }
}
