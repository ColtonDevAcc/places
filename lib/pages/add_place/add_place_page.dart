import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:places/pages/add_place/_widgets/bottomAddPlace_widget.dart';
import 'package:places/providers/general_providers.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddPlace_Page extends HookWidget {
  const AddPlace_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final networkImage = useProvider(networkImageProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(networkImage.state),
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
