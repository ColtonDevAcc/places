// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class PlaceRepsitoryBaseClass {
  Future<String> createPlace();
  Future<String> updatePlace();
  Future<String> deletePlace();
  Future<String> getPlaces();
}

final PlaceRepositoryProvider = Provider<PlaceRepository>((ref) => PlaceRepository(ref.read));

class PlaceRepository implements PlaceRepsitoryBaseClass {
  final Reader read;

  const PlaceRepository(this.read);

  @override
  Future<String> createPlace() {
    // TODO: implement createPlace
    throw UnimplementedError();
  }

  @override
  Future<String> deletePlace() {
    // TODO: implement deletePlace
    throw UnimplementedError();
  }

  @override
  Future<String> getPlaces() {
    // TODO: implement getPlaces
    throw UnimplementedError();
  }

  @override
  Future<String> updatePlace() {
    // TODO: implement updatePlace
    throw UnimplementedError();
  }
}
