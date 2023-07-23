import 'package:flutter/material.dart';

const smallDistance = 8.0;
const mediumDistance = 16.0;
const largeDistance = 24.0;
const xLargeDistance = 32.0;

const smallRadius = 8.0;
const mediumRadius = 16.0;
const largeRadius = 24.0;
const xLargeRadius = 32.0;

const iconSize = 24.0;

const primaryColor = Color(0xff2246B3);

//light colors
const greyColor = Color(0xff4A484E);
const backgroundColor = Color(0xff040304);

const light = FontWeight.w300;
const regular = FontWeight.w400;
const medium = FontWeight.w500;
const semiBold = FontWeight.w600;
const bold = FontWeight.w700;
const extraBold = FontWeight.w800;
const black = FontWeight.w900;

const darkColorScheme = ColorScheme(
  primary: primaryColor,
  primaryContainer: Colors.white,
  secondary: primaryColor,
  secondaryContainer: primaryColor,
  surface: primaryColor,
  background: backgroundColor,
  error: Colors.red,
  onPrimary: primaryColor,
  onSecondary: primaryColor,
  onSurface: Colors.white,
  onBackground: backgroundColor,
  onError: Colors.red,
  brightness: Brightness.dark,
);

ThemeData themeData(BuildContext context) {
  return ThemeData(
    canvasColor: Colors.white,
    primaryColor: primaryColor,
    cardColor:  Colors.black,
    scaffoldBackgroundColor: backgroundColor,
    iconTheme:
        const IconThemeData(color: Colors.white),
    colorScheme: darkColorScheme,
  );
}
