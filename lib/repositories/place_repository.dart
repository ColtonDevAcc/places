// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:places/extentions/firebase_extentions.dart';
import 'package:places/models/place/place_model.dart';
import 'package:places/providers/general_providers.dart';

abstract class PlaceRepsitoryBaseClass {
  Future<String> createPlace();
  Future<String> updatePlace();
  Future<void> deletePlace({place: Place});
  Future<List<Place>> getPlaces();
}

final placeRepositoryProvider = Provider<PlaceRepository>((ref) => PlaceRepository(ref.read));

class PlaceRepository implements PlaceRepsitoryBaseClass {
  final Reader read;
  const PlaceRepository(this.read);

  @override
  Future<String> createPlace({userID: String, place: Place}) async {
    final documentRef = await read(firebaseFirestoreProvider).placesRefrence(userID).add(
          place.toDocument(),
        );

    return documentRef.id;
  }

  @override
  Future<void> deletePlace({place: Place, userID: String}) async {
    await read(firebaseFirestoreProvider).placesRefrence(userID).doc(place.id!).delete();
  }

  @override
  Future<List<Place>> getPlaces({userID: String, querryType: PlaceQuerry}) async {
    List<Place> placeList = [];

    switch (querryType) {
      case PlaceQuerry.priceA:
        await read(firebaseFirestoreProvider)
            .placesRefrence(userID)
            .orderBy(
              'publishDate',
              descending: false,
            )
            .get()
            .then(
          (value) {
            value.docs.forEach(
              (place) {
                placeList.add(Place.fromDocument(place));
              },
            );
          },
        );
        break;

      default:
        await read(firebaseFirestoreProvider).placesRefrence(userID).get().then(
          (value) {
            value.docs.forEach(
              (place) {
                placeList.add(Place.fromDocument(place));
              },
            );
          },
        );
        break;
    }

    return placeList;
  }

  @override
  Future<String> updatePlace() {
    // TODO: implement updatePlace
    throw UnimplementedError();
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
