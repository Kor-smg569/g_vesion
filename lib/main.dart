import 'package:flutter/material.dart';
import 'add_project_screen.dart';

void main() {
  runApp(const MyApp());
}

class Project {
  String name;
  String? imageUrl;

  Project({required this.name, this.imageUrl});
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

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<Project> projects = [];

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
            onTap: () async {
              // 플러스 버튼이 눌렸을 때 다이얼로그를 통해 프로젝트 정보 입력 받기
              Project? newProject = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProjectScreen(),
                ),
              );

              if (newProject != null) {
                setState(() {
                  projects.add(newProject);
                });
              }
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
        child: ListView.builder(
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(projects[index].name),
              leading: projects[index].imageUrl != null
                  ? CircleAvatar(
                backgroundImage: NetworkImage(projects[index].imageUrl!),
              )
                  : CircleAvatar(),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: '프로젝트 목록',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.unarchive),
            label: '공유함',
          ),
        ],
      ),
    );
  }
}
