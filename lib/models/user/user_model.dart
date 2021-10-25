import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class User implements _$User {
  const User._();

  factory User({
    String? id,
    required String name,
    required double rating,
    required double price,
    required DateTime publishDate,
  }) = _User;

  factory User.empty() => User(
        name: '',
        rating: 0.0,
        price: 0.0,
        publishDate: DateTime.now(),
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove('id');
}

//flutter packages pub run build_runner watch --delete-conflicting-outputs