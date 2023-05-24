import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class AddEpisodeScreen extends StatefulWidget {
  @override
  _AddEpisodeScreenState createState() => _AddEpisodeScreenState();
}

class _AddEpisodeScreenState extends State<AddEpisodeScreen> {
  late File _audioFile;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the current user info

    _titleController = TextEditingController(text: "Title");
    _descriptionController = TextEditingController(text: "description");
  }

  Future<void> _pickAudio() async {
    File? audioFile = await pickAudioFile();
    if (audioFile != null) {
      // Do something with the selected audio file
      setState(() {
        _audioFile = audioFile;
      });
    }
  }

  Future<File?> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  void _submitForm() {
    if (_audioFile != null) {
      final audioPath = _audioFile.path.toString();
    } else {
      final audioPath = "false";
    }
    // Get the form field values
    final title = _titleController.text;
    final description = _descriptionController.text;

    print("title: $title");
    print("description: $description");
    print("audio file: $_audioFile");
    // TODO: Submit the episode info to the backend
    // Make sure to validate the form data before submitting
    // Also handle errors if the submission fails
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Theme(
        data: ThemeData(
          scaffoldBackgroundColor: Color(0xFF081624),
          textTheme: TextTheme(
            bodyMedium:
                TextStyle(color: Colors.white), // set the text color here
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Add Episode"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 85.0,
                      child: IconButton(
                        icon: Icon(Icons.audiotrack),
                        iconSize: 128.0,
                        onPressed: _pickAudio,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: TextButton(
                      onPressed: _pickAudio,
                      child: Text("Choose Audio"),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white, // sets the text color to white
                    ),
                    decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white, // sets the text color to white
                    ),
                    decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    margin: EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text("Add Episode"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}