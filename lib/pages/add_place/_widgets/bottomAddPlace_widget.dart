import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:places/controllers/placeList_controller.dart';
import 'package:places/models/place/place_model.dart';
import 'package:places/providers/general_providers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BottomAddPlace_Widget extends HookWidget {
  const BottomAddPlace_Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final networkImage = useProvider(networkImageProvider);
    final placeControllerProviderNotifier = useProvider(PlaceListControllerProvider.notifier);
    final focusNode = useFocusNode();
    final titleController = useTextEditingController();
    final overallRatingFieldState = useProvider(overallRatingFieldProvider);
    final priceRatingFieldState = useProvider(priceRatingFieldProvider);

    const List<String> priceRatingList = ['\$', '\$\$', '\$\$\$'];
    const List<String> overallRatingList = ['1', '2', '3', '4', '5'];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AddPlaceTextField_Widget(
            titleContoller: titleController,
            focusNode: focusNode,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddPlaceDropDowns(
                hintText: 'Select a price rating',
                values: priceRatingList,
                dropDownProvider: priceRatingFieldProvider,
              ),
              AddPlaceDropDowns(
                hintText: 'Select an overall rating',
                values: overallRatingList,
                dropDownProvider: overallRatingFieldProvider,
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  networkImage.state =
                      'https://picsum.photos/400/6${Random().nextInt(10)}${Random().nextInt(10)}';
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
                        'New Picture',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  placeControllerProviderNotifier.publishPlace(
                    place: Place(
                      name: titleController.text,
                      rating: overallRatingFieldState.state,
                      price: priceRatingFieldState.state,
                      publishDate: Timestamp.now().toDate(),
                      networkImage: networkImage.state,
                    ),
                  );

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
                        'Add Place',
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
    );
  }
}

class AddPlaceDropDowns extends ConsumerWidget {
  final String hintText;
  final List<String> values;
  final StateProvider<String> dropDownProvider;

  const AddPlaceDropDowns({
    Key? key,
    required this.dropDownProvider,
    required this.hintText,
    required this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var state = context.read(dropDownProvider).state;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      child: DropdownButton<String>(
        dropdownColor: Colors.black,
        value: state == 'null' ? null : watch(dropDownProvider).state,
        icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.green),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        hint: Text(
          hintText,
          style: TextStyle(color: Colors.white),
        ),
        underline: Container(
          height: 2,
          color: Colors.green,
        ),
        onChanged: (String? newValue) {
          print('this is the old value $state');
          watch(dropDownProvider).state = newValue!;
          print('this is the old value $state');
        },
        items: values.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(
              child: Text(
                value,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AddPlaceTextField_Widget extends HookWidget {
  final FocusNode focusNode;
  final TextEditingController titleContoller;

  const AddPlaceTextField_Widget({
    required this.focusNode,
    required this.titleContoller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: titleContoller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Enter your title here...',
        hintStyle: TextStyle(color: Colors.white.withOpacity(.8)),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          borderSide: BorderSide(color: Colors.green),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: 'Title',
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
