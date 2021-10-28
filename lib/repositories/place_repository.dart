// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:places/extentions/firebase_extentions.dart';
import 'package:places/models/place/place_model.dart';
import 'package:places/providers/general_providers.dart';

abstract class PlaceRepsitoryBaseClass {
  Future<String> createPlace();
  Future<void> updatePlace({userID: String, place: Place});
  Future<void> deletePlace({place: Place});
  Future<List<Place>> getPlaces();
}

final placeRepositoryProvider = Provider<PlaceRepository>((ref) => PlaceRepository(ref.read));

class PlaceRepository implements PlaceRepsitoryBaseClass {
  final Reader read;
  const PlaceRepository(this.read);

  @override
  Future<String> createPlace({userID: String, place: Place}) async {
    Place updatedPlace = place;
    final documentRef = await read(firebaseFirestoreProvider).placesRefrence(userID).add(
          place.toDocument(),
        );

    documentRef.set(updatedPlace.copyWith(id: documentRef.id).toDocument());

    return documentRef.id;
  }

  @override
  Future<void> deletePlace({place: Place, userID: String}) async {
    await read(firebaseFirestoreProvider).placesRefrence(userID).doc(place.id!).delete();
  }

  @override
  Future<List<Place>> getPlaces({userID: String, querryType: PlaceQuerry}) async {
    List<Place> placeList = [];

    try {
      await read(firebaseFirestoreProvider).placesRefrence(userID).get().then(
        (value) {
          value.docs.forEach(
            (place) {
              placeList.add(Place.fromDocument(place));
            },
          );
        },
      );

      return placeList;
    } catch (e) {
      log(e.toString());
      return placeList;
    }
  }

  @override
  Future<void> updatePlace({userID: String, place: Place}) async {
    try {
      print('${place.id}');

      await read(firebaseFirestoreProvider)
          .placesRefrence(userID)
          .doc(place.id)
          .update(place.toJson());
    } catch (e) {
      log(e.toString());
    }
  }
}

enum PlaceQuerry {
  titleA,
  titleD,
  publishA,
  publishD,
  priceA,
  priceD,
}
