import 'package:flutter/material.dart';
import 'package:places/controllers/auth_controller.dart';
import 'package:places/controllers/placeList_controller.dart';
import 'package:places/pages/add_place/add_place_page.dart';
import 'package:places/pages/home/widgets/expensive_places_widget.dart';
import 'package:places/pages/home/widgets/recent_places_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isSearchingdProvider = StateProvider<bool>((ref) => false);
final textEditingProvider = StateProvider<TextEditingController>((ref) => TextEditingController());

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final authController = context.read(authControllerProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPlace_Page()));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        items: [
          BottomNavigationBarItem(
            label: 'home',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: 'settings',
            icon: Icon(
              Icons.settings,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'home',
                    textScaleFactor: 2,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: authController != null
                        ? Icon(Icons.logout, color: Colors.black)
                        : Icon(Icons.login, color: Colors.green),
                  )
                ],
              ),
              SizedBox(height: 10),
              TextField(
                onChanged: (text) {
                  text.isEmpty
                      ? watch(isSearchingdProvider).state = false
                      : watch(isSearchingdProvider).state = true;
                },
                controller: watch(textEditingProvider).state,
                decoration: InputDecoration(
                  label: Text('Type to search'),
                  icon: Icon(Icons.search, color: Colors.black),
                ),
              ),
              SizedBox(height: 20),
              watch(isSearchingdProvider).state != true
                  ? Column(
                      children: [
                        RecentPlaces_Widget(),
                        SizedBox(height: 20),
                        Expensive_places_Widget(),
                      ],
                    )
                  : watch(PlaceListControllerProvider).when(
                      data: (places) {
                        places.sort(
                            (a, b) => '${watch(textEditingProvider).state.text}'.compareTo(a.name));

                        return Expanded(
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                title: Text(places[index].name),
                              );
                            },
                          ),
                        );
                      },
                      loading: () => CircularProgressIndicator(),
                      error: (e, st) {
                        return Text(e.toString());
                      })
            ],
          ),
        ),
      ),
    );
  }
}
