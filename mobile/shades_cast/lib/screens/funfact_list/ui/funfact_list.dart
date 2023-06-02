import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shades_cast/domain_layer/funfact.dart';
import 'package:shades_cast/screens/add_funfact/ui/add_funfact.dart';
import 'package:shades_cast/screens/favorite_podcasts/bloc/favorite_podcasts_bloc.dart';
import 'package:shades_cast/screens/funfact_list/bloc/funfact_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shades_cast/screens/edit_funfact/bloc/edit_funfact_bloc.dart';
import 'package:shades_cast/screens/edit_funfact/ui/editFunfact.dart';

class FunFactCard extends StatelessWidget {
  final String title;
  final String body;
  final String id;
  final VoidCallback onDelete;

  FunFactCard({
    required this.id,
    required this.title,
    required this.body,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final titleSyle =
        TextStyle(color: Color.fromARGB(255, 49, 217, 255), fontSize: 20);
    final bodyStyle = TextStyle(
        color: Color.fromARGB(255, 203, 203, 203),
        fontSize: 16,
        fontWeight: FontWeight.w300);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      child: Card(
        color: Color.fromARGB(105, 27, 65, 84),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          child: ListTile(
            title: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                title.toUpperCase(),
                style: titleSyle,
              ),
            ),
            subtitle: Text(
              body,
              style: bodyStyle,
            ),
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => editPodcasts(
                                    fact: Funfact(title: title, body: body),
                                    funfactId: int.parse(id),
                                  )),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 49, 217, 255),
                      )),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Color.fromARGB(255, 49, 217, 255),
                    ),
                    onPressed: onDelete,
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

class FunFactListScreen extends StatelessWidget {
  List<Funfact> funfacts = [];
  bool refresh;
  // Assuming each funfact has a title and body

  FunFactListScreen({this.refresh = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF081624),
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
          } else if (state is FunfactLoadingState) {
            return Center(
              child: SpinKitFadingCircle(
                color: Color.fromARGB(255, 37, 153, 255),
              ),
            );
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
                      // print(funfacts);
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
                id: (state.funfacts.length > 0) ? funfact.id! : "",
                onDelete: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteConfirmationDialog(
                        onConfirm: () {
                          BlocProvider.of<FunfactBloc>(context).add(
                              DeleteFunfact(funfactId: int.parse(funfact.id!)));
                        },
                      );
                    },
                  );
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

class DeleteConfirmationDialog extends StatelessWidget {
  final Function onConfirm;

  const DeleteConfirmationDialog({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content: Text('Are you sure you want to delete?'),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
        TextButton(
          child: Text('Delete'),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop(); // Close
            BlocProvider.of<FunfactBloc>(context).add(GetAllFunfacts());
          },
        ),
      ],
    );
  }
}
