import 'package:flutter/material.dart';
import 'package:shades_cast/domain_layer/funfact.dart';
import 'package:shades_cast/screens/add_funfact/ui/add_funfact.dart';
import 'package:shades_cast/screens/favorite_podcasts/bloc/favorite_podcasts_bloc.dart';
import 'package:shades_cast/screens/funfact_list/bloc/funfact_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final titleSyle = TextStyle(color: Colors.white, fontSize: 20);
    final bodySyle =
        TextStyle(color: Color.fromARGB(255, 203, 203, 203), fontSize: 16);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: Card(
        color: Color.fromARGB(255, 27, 65, 84),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          child: ListTile(
            title: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                title,
                style: titleSyle,
              ),
            ),
            subtitle: Text(
              body,
              style: bodySyle,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ),
        ),
      ),
    );
  }
}

class FunFactListScreen extends StatelessWidget {
  List<Funfact> funfacts = [];
  bool refresh;
  // Assuming each funfact has a title and body

  FunFactListScreen({this.refresh = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('FunFacts'),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Color.fromARGB(255, 49, 217, 255),
                size: 25,
              ),
              onPressed: () {
                BlocProvider.of<FunfactBloc>(context).add(GetAllFunfacts());
              },
            )
          ],
        ),
      ),
      body: BlocBuilder<FunfactBloc, FunfactState>(
        builder: (context, state) {
          funfacts = state.funfacts;
          if (refresh) {
            BlocProvider.of<FunfactBloc>(context).add(GetAllFunfacts());
            refresh = false;
          }
          if (state is FunfactInitial) {
            BlocProvider.of<FunfactBloc>(context).add(GetAllFunfacts());
          } else if (state is FunfactErrorState) {
            return Container(
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Error Occured. Try again",
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Color.fromARGB(255, 141, 141, 141),
                      size: 25,
                    ),
                    onPressed: () {
                      BlocProvider.of<FunfactBloc>(context)
                          .add(GetAllFunfacts());
                    },
                  )
                ],
              )),
            );
          }
          return ListView.builder(
            itemCount: funfacts.length,
            itemBuilder: (context, index) {
              final funfact = funfacts[index];

              return FunFactCard(
                title: (state.funfacts.length > 0) ? funfact.title : "",
                body: (state.funfacts.length > 0) ? funfact.body : "",
                onDelete: () {
                  // Implement the delete functionality here
                  // Call a method or use a BLoC to delete the funfact from the database
                  // Example: onDeleteFunFact(funfact['id']);
                },
              );
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
            MaterialPageRoute(
                builder: (context) => AddFunFactScreen(
                      refresh: true,
                    )),
          );
        },
      ),
    );
  }
}
