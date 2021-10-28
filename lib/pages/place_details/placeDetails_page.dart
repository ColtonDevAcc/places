import 'package:flutter/material.dart';
import 'package:places/controllers/placeList_controller.dart';
import 'package:places/models/place/place_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:places/pages/place_details/_widgets/bottomEditPlace_widget.dart';

final isEditingProvider = StateProvider<bool>((ref) => false);

class PlaceDetails_Page extends ConsumerWidget {
  final Place place;
  const PlaceDetails_Page({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(place.networkImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BottomPlaceDetails_Widget(place: place),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 45, 0, 0),
            child: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(.7),
                child: GestureDetector(
                  onTap: () {
                    watch(isEditingProvider).state = false;
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomPlaceDetails_Widget extends ConsumerWidget {
  final Place place;
  const BottomPlaceDetails_Widget({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return watch(isEditingProvider).state == false
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        textScaleFactor: 3,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'has a score of: ${place.rating}',
                        textScaleFactor: 1.4,
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'and a price rating of: ${place.price}',
                        textScaleFactor: 1.4,
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        watch(isEditingProvider).state = true;
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .43,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Center(
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        watch(PlaceListControllerProvider.notifier).deletePlace(place: place);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .43,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Center(
                            child: Text(
                              'Delete',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        : BottomEditPlace_Widget(place);
  }
}
