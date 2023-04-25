import 'package:flutter/material.dart';
import '../bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> podcasts = [];

  void generatePodcasts(onPressed) {
    podcasts = [];
    for (int i = 1; i < 21; i++) {
      podcasts
          .add(ElevatedButton(onPressed: onPressed, child: Text("Item $i")));
    }
  }

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("ShadesCast")),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          border: OutlineInputBorder(),
                          hintText: 'Enter a search term',
                          hintStyle: TextStyle(fontSize: 13),
                        ),
                        onEditingComplete: () {
                          String data = _searchController.value.text;
                          BlocProvider.of<HomeBloc>(context)
                              .add(SearchButtonClicked());
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: podcasts,
                      ),
                    )
                  ]),
            );
          },
        ));
  }
}
