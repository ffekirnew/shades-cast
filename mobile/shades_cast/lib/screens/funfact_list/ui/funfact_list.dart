import 'package:flutter/material.dart';
import 'package:shades_cast/screens/add_funfact/ui/add_funfact.dart';

class FunFactCard extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onDelete;

  FunFactCard({
    required this.title,
    required this.body,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(body),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}

class FunFactListScreen extends StatelessWidget {
  final List<Map<String, String>> funfacts = [
    {
      "title": "the main",
      "body":
          "the Road to victort if filled with hurdles but it is glorious. such is life"
    }
  ]; // Assuming each funfact has a title and body

  FunFactListScreen();

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
            title: Text('FunFacts'),
          ),
          body: ListView.builder(
            itemCount: funfacts.length,
            itemBuilder: (context, index) {
              final funfact = funfacts[index];
              return FunFactCard(
                title: funfact['title'] ?? '',
                body: funfact['body'] ?? '',
                onDelete: () {
                  // Implement the delete functionality here
                  // Call a method or use a BLoC to delete the funfact from the database
                  // Example: onDeleteFunFact(funfact['id']);
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              // Navigate to the AddFunFactScreen when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddFunFactScreen()),
              );
            },
          ),
        ),
      ),
    );
  }
}
