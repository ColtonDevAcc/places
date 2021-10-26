import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:places/pages/add_place/_widgets/bottomAddPlace_widget.dart';

final titleTextFieldProvider = StateProvider<String>((ref) => "");
final priceRatingFieldProvider = StateProvider<String>((ref) => 'null');
final overallRatingFieldProvider = StateProvider<String>((ref) => 'null');
final networkImageProvider = StateProvider<String>((ref) => 'https://picsum.photos/600/1200');

class AddPlace_Page extends ConsumerWidget {
  const AddPlace_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(watch(networkImageProvider).state),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: BottomAddPlace_Widget(),
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
