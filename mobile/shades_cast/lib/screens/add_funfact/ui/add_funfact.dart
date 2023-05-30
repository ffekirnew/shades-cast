import 'package:flutter/material.dart';
import 'package:shades_cast/screens/add_funfact/bloc/add_funfact_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shades_cast/screens/funfact_list/bloc/funfact_bloc.dart';

class AddFunFactScreen extends StatelessWidget {
  bool refresh;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  AddFunFactScreen({this.refresh = false});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add FunFact',
        ),
      ),
      body: BlocBuilder<AddFunfactBloc, AddFunfactState>(
        builder: (context, state) {
          Widget errorMessage = Container();
          if (state is FunfactErrorState) {
            errorMessage = Text(
              'Error Occured. Try again',
              style: TextStyle(color: Colors.red),
            );
          } else if (state is AddFunfactSuccessState) {
            errorMessage = Text(
              'Successfully added',
              style: TextStyle(color: Colors.green),
            );
          }
          if (refresh) {
            errorMessage = Text(
              '',
            );
            refresh = false;
          }
          return Padding(
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
                    final dynamic fact = {
                      'title': titleController.text,
                      'body': bodyController.text
                    };
                    BlocProvider.of<AddFunfactBloc>(context)
                        .add(FunfactSubmitted(fact: fact));
                  },
                  child: Text('Add FunFact'),
                ),
                Container(
                  child: errorMessage,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
