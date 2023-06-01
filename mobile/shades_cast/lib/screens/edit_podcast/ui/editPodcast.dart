import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:shades_cast/Infrustructure_layer/api_clients/authService.dart';
import 'package:shades_cast/screens/edit_podcast/bloc/edit_podcast_bloc.dart';
import '../../../Infrustructure_layer/api_clients/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shades_cast/domain_layer/podcast.dart';

import '../../../Infrustructure_layer/api_clients/podcast_repository.dart';
import '../../../repository/database/podcast_database.dart';

class editPodcasts extends StatefulWidget {
  // late final PodcastApiClient _apiClient;
  int podcastId;

  editPodcasts({required this.podcastId});

  @override
  _editPodcastsState createState() => _editPodcastsState();
}

class _editPodcastsState extends State<editPodcasts> {
  PodcastApiClient apiClient = PodcastApiClient();
  PodcastApiClient _apiClient = PodcastApiClient();
  PodcastDatabase _database = PodcastDatabase();

  late File _imageFile;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the current user info
    _imageFile = File('assets/logo.png');
    _firstNameController = TextEditingController(text: "John");
    _lastNameController = TextEditingController(text: "Doe");
    _usernameController = TextEditingController(text: "johndoe");
    _emailController = TextEditingController(text: "johndoe@example.com");
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
    }
  }

  void _submitForm() async {
    // Get the form field values

    dynamic modifiedPodcast = {
      "title": _firstNameController.text,
      "description": _lastNameController.text,
      "categories": _usernameController.text,
      "cover_image": _imageFile
    };

    BlocProvider.of<EditPodcastBloc>(context).add(EditPodcastSubmitted(
        modifiedPodcast: modifiedPodcast, podcastId: widget.podcastId));
    // PodcastRepository podRepo = PodcastRepositoryImpl(_database, _apiClient);
    // final res = await podRepo.searchPodcast('funny');
    // print(res);
    // print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: Color(0xFF081624),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // set the text color here
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF081624),
          title: Text("Edit Podcast"),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<EditPodcastBloc, EditPodcastState>(
              builder: (context, state) {
            String errorMessage = '';
            if (state is EditPodcastError) {
              errorMessage = 'Error occured. Try again';
            } else if (state is EditPodcastSuccess) {
              errorMessage = 'Podcast succesfully edited.';
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 60.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Center(
                    child: TextButton(
                      onPressed: _pickImage,
                      child: Text("Change Profile Picture"),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white, // sets the text color to white
                    ),
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: "Title",
                      fillColor: Colors.blue,
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white, // sets the text color to white
                    ),
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white, // sets the text color to white
                    ),
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "Category",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white, // sets the text color to white
                    ),
                    decoration: InputDecoration(
                      fillColor:
                          Colors.blue, // sets the background color to blue
                      labelStyle: TextStyle(color: Colors.blue),
                      labelText: "Email",
                    ),
                    controller: _emailController,
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(height: 32.0),
                  Container(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        "Edit Podcast",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        errorMessage,
                        style: TextStyle(
                            color: (errorMessage == 'Error occured. Try again')
                                ? Colors.red
                                : Colors.green,
                            fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}


// [
//   {
//     "creator": int,
//     "title": "string",
//     "slug": "string",
//     "description": "string",
//     "cover_image": "string",
//     "category": "string",
//     "publish": "2023-05-01T15:21:34.226Z",
//     "status": "private"
//   }
// ]