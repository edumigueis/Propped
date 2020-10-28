import 'package:flutter/material.dart';

class AdvancedColor{
  String colorName;
  Color color;

  AdvancedColor(Color color, String name){
    this.color = color;
    this.colorName = name;
  }

  String getName(){
    return this.colorName;
  }
  Color getColor(){
    return this.color;
  }
}