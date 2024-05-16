import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kSearchTextFeild = InputDecoration(
  hintText: 'Search',
  hintStyle: TextStyle(
    color: Color.fromARGB(255, 186, 186, 186),
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
  filled: true,
  fillColor: Color(0xFF272727),
  prefixIcon: Icon(
    Icons.search,
    color: Color.fromARGB(255, 186, 186, 186),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
  ),
);

TextStyle titleStyle =
    GoogleFonts.acme(fontSize: 20, fontWeight: FontWeight.w500);

TextStyle bodyStyle = GoogleFonts.exo2(
  textStyle: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  ),
);
