import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/pdf.dart' as pdf; // 이 가져오기 문장을 확인하세요.
import 'package:pdf/widgets.dart' as pw;


import 'project_data.dart';
import 'project_detail_page.dart';

class SharedProjectsPage extends StatefulWidget {
  @override
  _SharedProjectsPageState createState() => _SharedProjectsPageState();
}

class _SharedProjectsPageState extends State<SharedProjectsPage> {
  List<Project> _selectedProjects = [];
  List<Project> _projects = []; // 저장된 프로젝트 목록

  @override
  void initState() {
    super.initState();
    // 저장된 프로젝트 목록을 가져와서 _projects에 할당합니다.
    _projects = ProjectData().projects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공유된 프로젝트'),
      ),
      body: ListView.builder(
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          final project = _projects[index];
          return ListTile(
            title: Text(project.name),
            subtitle: Text(
                'Creation Date: ${DateFormat.yMMMd().format(
                    project.creationDate)}'),
            onTap: () {
              setState(() {
                // 선택된 프로젝트들을 toggle합니다.
                _selectedProjects.contains(project)
                    ? _selectedProjects.remove(project)
                    : _selectedProjects.add(project);
              });
            },
            // 선택된 프로젝트인 경우 체크 아이콘 표시
            trailing: _selectedProjects.contains(project)
                ? Icon(Icons.check_circle, color: Colors.blue)
                : null,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSelectProjectsDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showSelectProjectsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('프로젝트 선택'),
          content: SingleChildScrollView(
            child: Column(
              children: _projects.map((project) {
                return CheckboxListTile(
                  title: Text(project.name),
                  value: _selectedProjects.contains(project),
                  onChanged: (value) {
                    setState(() {
                      value!
                          ? _selectedProjects.add(project)
                          : _selectedProjects.remove(project);
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                _exportSelectedProjectsToPdf(_selectedProjects);
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void _exportSelectedProjectsToPdf(List<Project> selectedProjects) async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      build: (context) {
        return selectedProjects.map((project) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('프로젝트 이름: ${project.name}'),
              pw.Text(
                  '생성 일자: ${DateFormat.yMMMd().format(project.creationDate)}'),
              pw.Text(_getProjectDetail(project)),
              pw.SizedBox(height: 20),
            ],
          );
        }).toList();
      },
    ));

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/selected_projects_details.pdf';

    final File file = File(path);
    await file.writeAsBytes(await pdf.save());

    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('PDF 파일 생성'),
            content: Text('선택한 프로젝트 내용을 PDF 파일로 내보냈습니다. 파일 경로: $path'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
              TextButton(
                onPressed: () {
                  // 생성된 PDF 파일을 열기
                  _openFile(file);
                },
                child: Text('열기'),
              ),
            ],
          ),
    );
  }

  void _openFile(File file) {
    // 플랫폼에 따라 파일을 열기
    if (Platform.isAndroid) {
      // 안드로이드의 경우 Intent를 사용하여 파일을 엽니다.
      OpenFile.open(file.path);
    } else {
      // iOS의 경우 UIDocumentInteractionController를 사용하여 파일을 엽니다.
      // 여기에 iOS에서 파일을 열기 위한 코드를 추가하세요.
      print('iOS에서는 파일을 열 수 없습니다.');
    }
  }

  String _getProjectDetail(Project project) {
    // 프로젝트 세부 정보를 문자열로 반환합니다.
    String details = '';

    // 프로젝트 세부 정보를 추가합니다.
    details += '프로젝트 이름: ${project.name}\n';
    details +=
    '생성 일자: ${DateFormat.yMMMd().format(project.creationDate)}\n';

    // 프로젝트의 이미지 URL이 있는 경우 이미지 정보를 추가합니다.
    if (project.imageUrl != null) {
      details += '이미지 URL: ${project.imageUrl}\n';
    } else {
      details += '이미지 없음\n';
    }

    // 프로젝트의 모니터링 데이터를 추가합니다.
    details += '측정 항목:\n';
    project.measurements.forEach((key, value) {
      details += '$key: $value\n';
    });

    return details;
  }
}
