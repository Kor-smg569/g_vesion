import 'dart:io';
import 'package:flutter/material.dart';

class Project {
  String name;
  String? imageUrl;
  DateTime creationDate;
  Map<String, bool> monitoringItems;  // For tracking monitoring items
  Map<String, dynamic> measurements;  // For storing measurements

  Project({
    required this.name,
    this.imageUrl,
    required this.creationDate,
    required this.monitoringItems,
    required this.measurements,
  });
// Other methods and logic...
}


class ProjectData extends ChangeNotifier {
  List<Project> _projects = [];

  List<Project> get projects => _projects;

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }

  void editProjectName(int index, String newName) {
    if (index >= 0 && index < _projects.length) {
      _projects[index].name = newName;
      notifyListeners();
    }
  }

  void deleteProject(int index) {
    if (index >= 0 && index < _projects.length) {
      _projects.removeAt(index);
      notifyListeners();
    }
  }

// 필요한 경우 추가 기능을 여기에 구현할 수 있습니다.
}
