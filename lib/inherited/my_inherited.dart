// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class GetInfoUser extends InheritedWidget {
  GetInfoUser({
    super.key,
    required this.child,
    this.appTitle,
    this.id,
    this.accessToken,
    this.refreshToken,
    this.userEmail,
    this.fullName,
    this.image,
    this.conexion,
  }) : super(child: child);

  final Widget child;
  String? appTitle;
  String? id;
  String? accessToken;
  String? refreshToken;
  String? userEmail;
  String? fullName;
  String? image;
  bool? conexion;

  static GetInfoUser of(BuildContext context) {
    final GetInfoUser? result =
        context.dependOnInheritedWidgetOfExactType<GetInfoUser>();

    return result!;
  }

  @override
  bool updateShouldNotify(GetInfoUser oldWidget) {
    return true;
  }

  void setAppTitle(String appTitle) {
    this.appTitle = appTitle;
  }

  void setId(String id) {
    this.id = id;
  }

  void setAccessToken(String accessToken) {
    this.accessToken = accessToken;
  }

  void setRefreshToken(String refreshToken) {
    this.refreshToken = refreshToken;
  }

  void setEmail(String userEmail) {
    this.userEmail = userEmail;
  }

  void setFullName(String firstName, String lastName) {
    fullName = '$firstName $lastName';
  }

  void setImage(String image) {
    this.image = image;
  }

  void setConexion(bool conexion) {
    this.conexion = conexion;
  }
}
