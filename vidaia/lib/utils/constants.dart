import 'package:flutter/material.dart';

const Color PRIMARY = Color(0xff0b2b2d);
const Color PRIMARY_LIGHT = Color(0xff6c9772);
const Color PRIMARY_DARK = Color(0xff112823);

const Color BUTTON = Color(0xffffb900);
const Color CLICKED = Color(0xffd19000);

const Color SPEND = Color.fromARGB(255, 245, 124, 102);

const Color BACKGROUND = Color(0xfff8faf7);
const Color BACKGROUND_SHADE = Color(0xffebeeea);
const Color SECONDARY = Color.fromARGB(255, 197, 197, 197);
const Color DARK_GRADIENT = Color.fromARGB(255, 0, 0, 0);
const Color TRANSPARENT_GRADIENT = Color.fromARGB(0, 0, 0, 0);

const Color TEXT_WHITE = Color(0xfff8faf7);

final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: TEXT_WHITE,
  textStyle: const TextStyle(color: TEXT_WHITE),
  primary: PRIMARY_LIGHT,
  minimumSize: const Size.fromHeight(36),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);
final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
  textStyle: const TextStyle(color: TEXT_WHITE),
  primary: TEXT_WHITE,
  minimumSize: const Size.fromHeight(36),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  side: BorderSide(width: 1.0, color: TEXT_WHITE),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);
