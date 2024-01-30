import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../lib/project_data.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final TextEditingController nameController = TextEditingController();
  File? selectedImage;

  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미지 선택 중 오류 발생: $e')),
      );
    }
  }

  Future<void> _createProject() async {
    if (nameController.text.isNotEmpty) {
      Project newProject = Project(
        name: nameController.text,
        imageUrl: selectedImage,
        creationDate: DateTime.now(),
      );

      Provider.of<ProjectData>(context, listen: false).addProject(newProject);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('프로젝트 이름을 입력하세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Project')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildNameTextField(),
            const SizedBox(height: 16.0),
            _buildSelectImageButton(),
            const SizedBox(height: 16.0),
            _buildSelectedImagePreview(),
            const SizedBox(height: 16.0),
            _buildAddProjectButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return TextField(
      controller: nameController,
      decoration: const InputDecoration(labelText: 'Project Name'),
    );
  }

  Widget _buildSelectImageButton() {
    return ElevatedButton(
      onPressed: _getImage,
      child: const Text('Select Image'),
    );
  }

  Widget _buildSelectedImagePreview() {
    return selectedImage != null
        ? Image.file(
      selectedImage!,
      height: 150,
      fit: BoxFit.cover,
    )
        : const SizedBox(height: 150); // Placeholder for no image selected
  }

  Widget _buildAddProjectButton() {
    return ElevatedButton(
      onPressed: _createProject,
      child: const Text('Add Project'),
    );
  }
}
