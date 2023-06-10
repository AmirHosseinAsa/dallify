import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const String AplicationName = "Dallify";
const Color background_container_generated_image = Color(0xff27272A);
const Color background_sidebar = Color(0xff18181B);
const Color backgroun_titlebar = Color.fromARGB(255, 20, 20, 20);
const Color sub_button_color = Color.fromARGB(255, 0, 123, 180);

bool canGenerate = true;
String textFiledGenerateValue = '';

final spinkitPulse = SpinKitPulse(
  color: Colors.white,
  size: 100.0,
);
const String version = 'v1.0.0';
const String mailing =
    'mailto:amirhossein.asa.official@gmail.com?subject=[Dallify Ai Image Generator: (Ver: $version)]';
const String storeSearch =
    'https://www.microsoft.com/en-us/search/explore?q=Dollify+Best+Ai+Image+Creator';

const String portServ = '7169';

Gradient gradientTheme = LinearGradient(colors: [
  Color(0xff00F5A0),
  Color(0xff0099FF),
]);

Gradient reversedGradientTheme = LinearGradient(colors: [
  Color(0xff0099FF),
  Color(0xff00F5A0),
]);

Gradient darkenGradientTheme = LinearGradient(colors: [
  Color.fromARGB(255, 0, 66, 110),
  Color.fromARGB(255, 0, 108, 180),
]);
