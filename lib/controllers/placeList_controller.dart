import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:places/controllers/auth_controller.dart';
import 'package:places/models/place/place_model.dart';
import 'package:places/repositories/exceptions_repository.dart';
import 'package:places/repositories/place_repository.dart';

final PlaceListControllerProvider =
    StateNotifierProvider<PlaceListController, AsyncValue<List<Place>>>((ref) {
  final user = ref.watch(authControllerProvider);
  return PlaceListController(ref.read, user!.uid);
});

final groupListExceptionProvider = StateProvider<CustomException?>((_) => null);

class PlaceListController extends StateNotifier<AsyncValue<List<Place>>> {
  final Reader read;
  final String? userID;

  PlaceListController(this.read, this.userID) : super(AsyncValue.loading()) {
    if (userID != null) {
      retrievePlaces();
    } else {
      log('user id is null');
    }
  }

  Future<void> retrievePlaces({querryType: PlaceQuerry}) async {
    try {
      List<Place> placeList = await read(placeRepositoryProvider).getPlaces(userID: userID!);
      if (mounted) {
        state = await AsyncValue.data(placeList);
        log('groups is empty ${placeList.isEmpty}');
      }
    } on CustomException catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> publishPlace({place: Place}) async {
    final placeID = await read(placeRepositoryProvider).createPlace(userID: userID, place: place);

    state.whenData(
      (places) => state = AsyncValue.data(
        places
          ..add(
            place.copyWith(id: placeID),
          ),
      ),
    );
  }

  Future<void> deletePlace({place: Place}) async {
    await read(placeRepositoryProvider).deletePlace(place: place, userID: userID);

    state.whenData(
      (places) => state = AsyncValue.data(
        places
          ..remove(
            place.copyWith(id: place.id),
          ),
      ),
    );
  }

  Future<void> updatePlace({oldPlace: Place, updatedPlace: Place}) async {
    await read(placeRepositoryProvider).updatePlace(userID: userID, place: updatedPlace);

    state.whenData(
      (places) => state = AsyncValue.data(
        places
          ..remove(
            oldPlace,
          )
          ..add(updatedPlace.copyWith(id: updatedPlace.id)),
      ),
    );
  }
}
