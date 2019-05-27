import 'package:flutter/material.dart';

class User {
  final int userId;
  final String userType;
  final String name;
  final int rating;
  final String jwt;

  User({
    @required this.userId,
    @required this.userType,
    @required this.name,
    @required this.rating,
    @required this.jwt
  });
}
