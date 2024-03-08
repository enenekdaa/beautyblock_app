import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalBeautyColor {
  static const buttonHotPink = Color.fromRGBO(239, 1, 141, 1);
  static final lightGray = Color.fromRGBO(213, 212, 208, 1);
  static const middleBlack = Color.fromRGBO(54, 52, 47, 1);
  static final tagGray170 = Color.fromRGBO(174, 173, 170, 1);
}

class Server {
  static const baseUrl = 'http://52.79.64.155:8080';
}

void prefStrSave(key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
  print('local save str :: $key = $value');
}

void prefBoolSave(key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
  print('local save bool :: $key = $value');
}

void prefIntSave(key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
  print('local save int :: $key = $value');
}

Future<String> getPrefStr(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String result = prefs.getString(key) ?? '';
  return result;
}

Future<bool> getPrefBool(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool result = prefs.getBool(key) ?? false;
  return result;
}

Future<int> getPrefInt(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int result = prefs.getInt(key) ?? 0;
  return result;
}

void deletePref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
