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
              Project? newProject = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProjectScreen(),
                ),
              );

              if (newProject != null) {
                setState(() {
                  projects.insert(0, newProject);
                  projects.sort(
                          (a, b) => b.creationDate!.compareTo(a.creationDate!));
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
            return Card(
              child: Container(
                width: double.infinity,
                height: 120.0,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.grey[300],
                      ),
                      child: projects[index].imageUrl != null
                          ? AspectRatio(
                        aspectRatio: 1.0, // 1:1 비율로 유지
                        child: Image.file(
                          projects[index].imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      )
                          : const SizedBox(), // Null safety: Use SizedBox for an empty container
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              projects[index].name,
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            projects[index].creationDate != null
                                ? Text('Creation Date: ${projects[index].creationDate}')
                                : const Text('Creation Date: N/A'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15.0),
                      child: PopupMenuButton(
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('이름 편집'),
                                onTap: () async {
                                  String? editedName = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      String newName = projects[index].name;
                                      return AlertDialog(
                                        title: Text('프로젝트 이름 편집'),
                                        content: TextField(
                                          controller: TextEditingController(text: newName),
                                          onChanged: (value) {
                                            newName = value;
                                          },
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context); // 취소 버튼
                                            },
                                            child: Text('취소'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // 수정된 이름을 가져와서 저장하는 코드
                                              Navigator.pop(context, newName);
                                            },
                                            child: Text('확인'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (editedName != null) {
                                    setState(() {
                                      projects[index].name = editedName;
                                    });
                                  }

                                  Navigator.pop(context); // 팝업 메뉴 닫기
                                },
                              ),
                            ),
                            PopupMenuItem(
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('프로젝트 삭제'),
                                onTap: () {
                                  // 프로젝트 삭제 액션을 처리하는 코드
                                  setState(() {
                                    projects.removeAt(index);
                                  });
                                  Navigator.pop(context); // 팝업 메뉴 닫기
                                },
                              ),
                            ),
                          ];
                        },
                      ),
                    ),
                  ],
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
