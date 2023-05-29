import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/podcast_api_client.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:shades_cast/Infrustructure_layer/api_clients/authService.dart';
import 'package:shades_cast/screens/add_podcast/bloc/add_podcast_bloc.dart';
import '../../../Infrustructure_layer/api_clients/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shades_cast/domain_layer/podcast.dart';

class addPodcasts extends StatefulWidget {
  // late final PodcastApiClient _apiClient;

  addPodcasts();
  @override
  _addPodcastsState createState() => _addPodcastsState();
}

class _addPodcastsState extends State<addPodcasts> {
  PodcastApiClient apiClient = PodcastApiClient();
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
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  void _submitForm() async {
    // Get the form field values

    dynamic createdPodcast = {
      "title": _firstNameController.text,
      "description": _lastNameController.text,
      "categories": _usernameController.text,
      "cover_image": _imageFile
    };

    BlocProvider.of<AddPodcastBloc>(context)
        .add(PodcastSubmitted(createdPodcast: createdPodcast));
    // print(createdPodcast);

    // final res = await apiClient.addPodcast(podcast);
    // print(res);
    // final AuthService authService = AuthService();

    // var stream = http.ByteStream(_imageFile.openRead());
    // stream.cast();
    // var length = await _imageFile.length();
    // var uri = Uri.parse('http://192.168.0.144:8000/api/v2/podcasts/');
    // var request = http.MultipartRequest('POST', uri);
    // String? token = await authService.getToken();

    // request.headers['Authorization'] = 'Token $token';
    // request.fields['title'] = "shamil";
    // request.fields['categories'] = _usernameController.text;

    // var multipartFile = http.MultipartFile(
    //   'cover_image',
    //   stream,
    //   length,
    //   filename: path.basename(_imageFile.path), // Use the original filename
    // );
    // request.files.add(multipartFile);
    // request.fields['cover_image'] = path.basename(_imageFile.path);

    // try {
    //   var response = await request.send();
    //   if (response.statusCode != 200) {
    //     print((response.statusCode));
    //     print("Error sending the file");
    //   } else {
    //     print('Success');
    //   }
    // } catch (e) {
    //   print("Error: $e");
    // }
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
          title: Text("Add Podcast"),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<AddPodcastBloc, AddPodcastState>(
              builder: (context, state) {
            String errorMessage = '';
            if (state is AddPodcastError) {
              errorMessage = 'Error occured. Try again';
            } else if (state is AddPodcastSuccess) {
              errorMessage = 'Podcast succesfully added.';
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
                        "Create Podcast",
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