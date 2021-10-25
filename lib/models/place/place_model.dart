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
    required double rating,
    required double price,
    required DateTime publishDate,
  }) = _Place;

  factory Place.empty() => Place(
        name: '',
        rating: 0.0,
        price: 0.0,
        publishDate: DateTime.now(),
      );

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  factory Place.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Place.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}
