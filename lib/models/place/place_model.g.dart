// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Place _$_$_PlaceFromJson(Map<String, dynamic> json) {
  return _$_Place(
    id: json['id'] as String?,
    name: json['name'] as String,
    rating: (json['rating'] as num).toDouble(),
    price: (json['price'] as num).toDouble(),
    publishDate: DateTime.parse(json['publishDate'] as String),
  );
}

Map<String, dynamic> _$_$_PlaceToJson(_$_Place instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'price': instance.price,
      'publishDate': instance.publishDate.toIso8601String(),
    };
