import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shades_cast/Infrustructure_layer/api_clients/user_api_client.dart';

class AccountSettingsScreen extends StatefulWidget {
  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  UserApiClient apiClient = UserApiClient();

  late File _imageFile;
  late bool _isImageSelected = false;
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
    bool _isImageSelected = false;

    _imageFile;
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
        _isImageSelected = true;
      }
    });
  }

  void _submitForm() async {
    // TODO: Submit the updated user info to the backend
    // Make sure to validate the form data before submitting
    // Also handle errors if the submission fails
    // dynamic newUser = {
    //   "first_name": _firstNameController.text,
    //   "last_name": _lastNameController.text,
    //   "username": _usernameController.text,
    //   "email": _emailController.text,
    //   "password": _passwordController.text
    // };
    // dynamic profile = {
    //   "profile_pic": _imageFile,
    // };
    // final res = await apiClient.updateUser(profile);
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
          title: Text("Account Settings"),
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
                      radius: 50.0,
                      backgroundImage: _isImageSelected
                          ? FileImage(_imageFile)
                          : // Display the selected image if available
                          AssetImage('assets/logo.png') as ImageProvider<
                              Object>, // Display a default image
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
                    labelText: "First Name",
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
                    labelText: "Last Name",
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
                    labelText: "Username",
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
                TextFormField(
                  style: TextStyle(
                    color: Colors.white, // sets the text color to white
                  ),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "New password",
                    labelStyle: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  style: TextStyle(
                    color: Colors.white, // sets the text color to white
                  ),
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text("Save Changes"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
