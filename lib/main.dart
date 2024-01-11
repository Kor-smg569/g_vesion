import 'package:flutter/material.dart';
import 'dart:io';

import 'add_project_screen.dart';

void main() {
  runApp(const MyApp());
}

class Project {
  String name;
  File? imageUrl;
  DateTime? creationDate;

  Project({required this.name, this.imageUrl, this.creationDate});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'G-VISION',
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff4CAF50)),
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

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
          child: Text('G-VISION'),
        ),
        elevation: 0.0,
        actions: [
          GestureDetector(
            onTap: () async {
              // Navigate to AddProjectScreen and get the new project
              Project? newProject = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProjectScreen(),
                ),
              );

              if (newProject != null) {
                setState(() {
                  // Add the new project to the beginning of the list
                  projects.insert(0, newProject);
                  // Sort the projects in reverse order based on creationDate
                  projects.sort((a, b) => b.creationDate!.compareTo(a.creationDate!));
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
            return Container(
              width: 310,
              height: 100,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(projects[index].name),
                subtitle: projects[index].creationDate != null
                    ? Text('Creation Date: ${projects[index].creationDate}')
                    : const Text('Creation Date: N/A'),
                leading: Container(
                  width: 90,
                  height: 90,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[300],
                  ),
                  child: projects[index].imageUrl != null
                      ? Image.file(
                    projects[index].imageUrl!,
                    fit: BoxFit.cover,
                  )
                      : const SizedBox(), // Null safety: Use SizedBox for an empty container
                ),
              ),
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