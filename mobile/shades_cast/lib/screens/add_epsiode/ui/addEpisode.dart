import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

import '../../../Infrustructure_layer/api_clients/authService.dart';
import '../../../Infrustructure_layer/api_clients/podcast_api_client.dart';

class AddEpisodeScreen extends StatefulWidget {
  @override
  _AddEpisodeScreenState createState() => _AddEpisodeScreenState();
}

class _AddEpisodeScreenState extends State<AddEpisodeScreen> {
  PodcastApiClient apiClient = PodcastApiClient();

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

  Future<File> _pickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    } else {
      throw Exception("No audio file selected");
    }
  }

  Future<File?> pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      _audioFile = File(result.files.single.path!);
    } else {
      return null;
    }
  }

  void _submitForm() async {
    // final AuthService authService = AuthService();
    // String? token = await authService.getToken();

    var uri = Uri.parse('http://192.168.0.144:8000/api/v2/episodes/');
    var request = http.MultipartRequest('POST', uri);

    // request.headers['Authorization'] = 'Token $token';
    request.fields['title'] = _titleController.text;
    request.fields['tags'] = _descriptionController.text;
    request.fields['podcast'] = "1";

    if (_audioFile == null) {
      await _pickAudio(); // Use await to get the selected audio file
    }

    dynamic episode = {
      "title": _titleController.text,
      "description": _descriptionController.text,
      "podcast": "1",
      "_audioFile": _audioFile,
    };
    apiClient.addEpisode(episode);

    // if (_audioFile != null) {
    //   var stream = http.ByteStream(_audioFile.openRead());
    //   stream.cast();
    //   var length = await _audioFile.length();

    //   var multipartFile = http.MultipartFile(
    //     'audio_file',
    //     stream,
    //     length,
    //     filename: path.basename(_audioFile.path),
    //   );

    //   request.files.add(multipartFile);

    //   try {
    //     var response = await request.send();
    //     if (response.statusCode != 200) {
    //       print((response.statusCode));
    //       print("Error sending the file");
    //     } else {
    //       print('Success');
    //     }
    //   } catch (e) {
    //     print("Error: $e");
    //   }
    // } else {
    //   print("No audio file selected");
    // }
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
