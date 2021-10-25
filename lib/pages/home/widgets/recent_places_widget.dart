import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/pages/home/widgets/place_card_widget.dart';

class RecentPlaces_Widget extends StatelessWidget {
  const RecentPlaces_Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Places',
              textScaleFactor: 1.2,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text(
                'View All',
                textScaleFactor: 1,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 250,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              PlaceCard_Widget(),
              PlaceCard_Widget(),
              PlaceCard_Widget(),
              PlaceCard_Widget(),
            ],
          ),
        ),
      ],
    );
  }
}
