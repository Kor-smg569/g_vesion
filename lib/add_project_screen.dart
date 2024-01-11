import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  TextEditingController nameController = TextEditingController();
  File? selectedImage;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      }
    });
  }

  Future<void> _createProject() async {
    if (nameController.text.isNotEmpty) {
      Project newProject = Project(
        name: nameController.text,
        imageUrl: selectedImage,
        creationDate: DateTime.now(), // Set the creation date
      );

      Navigator.pop(context, newProject);
    } else {
      // 이름이 비어있을 경우 경고 표시
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('프로젝트 이름을 입력하세요.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Project Name'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Select Image'),
            ),
            const SizedBox(height: 16.0),
            selectedImage != null
                ? Image.file(
              selectedImage!,
              height: 150,
              fit: BoxFit.cover,
            )
                : const SizedBox(height: 150), // Placeholder for the selected image
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createProject,
              child: Text('Add Project'),
            ),
          ],
        ),
      ),
    );
  }
}