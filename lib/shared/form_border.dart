import 'package:flutter/material.dart';

InputDecoration textInputDecoration = InputDecoration(
  fillColor: Colors.white.withOpacity(0.8),
  filled: true,
  contentPadding: EdgeInsets.all(15.0),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(color: Colors.white10, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25.0),
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
  ),
);