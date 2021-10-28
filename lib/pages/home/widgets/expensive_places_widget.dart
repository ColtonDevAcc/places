import 'package:flutter/material.dart';
import 'package:places/controllers/placeList_controller.dart';
import 'package:places/models/place/place_model.dart';
import 'package:places/pages/home/widgets/place_card_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:places/pages/place_details/placeDetails_page.dart';

class Expensive_places_Widget extends ConsumerWidget {
  const Expensive_places_Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Most Expensive Places',
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
          child: watch(PlaceListControllerProvider).when(
            data: (place) {
              List<Place> places = place;

              //list sort
              //!TODO: make this a query by adding querry type to PlaceRepository
              place.sort(
                (a, b) => b.price.length.compareTo(a.price.length),
              );

              return ListView.builder(
                itemCount: places.length,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceDetails_Page(
                            place: places[index],
                          ),
                        ),
                      );
                    },
                    child: PlaceCard_Widget(
                      title: places[index].name,
                      rating: places[index].rating,
                      priceRating: places[index].price,
                      dateTime: places[index].publishDate,
                      networkImage: places[index].networkImage,
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              );
            },
            loading: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (e, st) {
              return Text('$e, $st');
            },
          ),
        ),
      ],
    );
  }
}
