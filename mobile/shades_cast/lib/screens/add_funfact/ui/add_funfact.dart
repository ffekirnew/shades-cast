import 'package:flutter/material.dart';

class AddFunFactScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add FunFact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(
                labelText: 'Body',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement the add functionality here
                // Call a method or use a BLoC to add the funfact to the database
                // Example: onAddFunFact(titleController.text, bodyController.text);
                // Navigator.pop(
                //     context); // Go back to the FunFactListScreen after adding
              },
              child: Text('Add FunFact'),
            ),
          ],
        ),
      ),
    );
  }
}
