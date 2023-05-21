import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class addPodcasts extends StatefulWidget {
  addPodcasts();
  @override
  _addPodcastsState createState() => _addPodcastsState();
}

class _addPodcastsState extends State<addPodcasts> {
  late Image _imageFile;
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
    _imageFile = Image.asset("assets/logo.png");
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
        _imageFile = Image.file(File(pickedFile.path));
      }
    });
  }

  void _submitForm() {
    // Get the image file path as a string
    final imagePath = _imageFile;

    // Get the form field values
    final title = _firstNameController.text;
    final description = _lastNameController.text;
    final category = _usernameController.text;
    final email = _emailController.text;

    // Print the form data to the console
    print("Title: $title");
    print("Description: $description");
    print("Category: $category");
    print("Email: $email");
    print("Image Path: $imagePath");
    // TODO: Submit the updated user info to the backend
    // Make sure to validate the form data before submitting
    // Also handle errors if the submission fails
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: _imageFile.image,
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
                    fillColor: Colors.blue, // sets the background color to blue
                    labelStyle: TextStyle(color: Colors.blue),
                    labelText: "Email",
                  ),
                  controller: _emailController,
                ),
                SizedBox(height: 16.0),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text("create Podcast"),
                ),
              ],
            ),
          ),
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