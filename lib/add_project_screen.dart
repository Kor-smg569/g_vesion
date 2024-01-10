import 'package:flutter/material.dart';
import 'main.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로젝트 추가'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: '프로젝트 이름'),
            ),
            TextField(
              controller: imageUrlController,
              decoration: InputDecoration(labelText: '이미지 URL (선택)'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String? imageUrl =
                imageUrlController.text.isNotEmpty ? imageUrlController.text : null;

                if (name.isNotEmpty) {
                  Navigator.of(context).pop(Project(name: name, imageUrl: imageUrl));
                } else {
                  // 이름이 비어있을 경우 경고 표시
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('프로젝트 이름을 입력하세요.'),
                  ));
                }
              },
              child: Text('프로젝트 생성'),
            ),
          ],
        ),
      ),
    );
  }
}
