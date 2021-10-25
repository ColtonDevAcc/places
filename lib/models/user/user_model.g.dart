// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    id: json['id'] as String?,
    name: json['name'] as String,
    rating: (json['rating'] as num).toDouble(),
    price: (json['price'] as num).toDouble(),
    publishDate: DateTime.parse(json['publishDate'] as String),
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rating': instance.rating,
      'price': instance.price,
      'publishDate': instance.publishDate.toIso8601String(),
    };
