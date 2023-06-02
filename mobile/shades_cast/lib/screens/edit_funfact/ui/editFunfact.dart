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

import 'package:shades_cast/screens/edit_funfact/bloc/edit_funfact_bloc.dart';
import 'package:shades_cast/domain_layer/funfact.dart';

class editPodcasts extends StatefulWidget {
  // late final PodcastApiClient _apiClient;
  Funfact fact;
  int funfactId;
  editPodcasts({required this.fact, required this.funfactId});

  @override
  _editPodcastsState createState() => _editPodcastsState();
}

class _editPodcastsState extends State<editPodcasts> {
  PodcastApiClient apiClient = PodcastApiClient();
  PodcastApiClient _apiClient = PodcastApiClient();
  PodcastDatabase _database = PodcastDatabase();

  late File _imageFile;
  late TextEditingController _titleController;
  late TextEditingController _bodyController;
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the current user info
    _titleController = TextEditingController(text: widget.fact.title);
    _bodyController = TextEditingController(text: widget.fact.body);
  }

  void _submitForm() async {
    // Get the form field values

    dynamic modifiedFunfact = {
      "title": _titleController.text,
      "body": _bodyController.text,
    };
    print(widget.funfactId);

    BlocProvider.of<EditFunfactBloc>(context).add(EditFunfactSubmitted(
        modifiedFunfact: modifiedFunfact, FunfactId: widget.funfactId));
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
          title: Text("Edit Funfact"),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<EditFunfactBloc, EditFunfactState>(
              builder: (context, state) {
            String errorMessage = '';
            if (state is EditFunfactError) {
              errorMessage = 'Error occured. Try again';
            } else if (state is EditFunfactSuccess) {
              errorMessage = 'Funfact succesfully edited.';
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white, // sets the text color to white
                    ),
                    controller: _titleController,
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
                    controller: _bodyController,
                    decoration: InputDecoration(
                      labelText: "Body",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  Container(
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        "Edit Funfact",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
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