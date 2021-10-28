import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_model.freezed.dart';
part 'place_model.g.dart';

@freezed
abstract class Place implements _$Place {
  const Place._();

  factory Place({
    String? id,
    required String name,
    required String rating,
    required String price,
    required DateTime publishDate,
    required String networkImage,
  }) = _Place;

  factory Place.empty() => Place(
        name: '',
        rating: '',
        price: '',
        networkImage: 'https://picsum.photos/800/400',
        publishDate: Timestamp.now().toDate(),
      );

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  factory Place.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Place.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson();
}
