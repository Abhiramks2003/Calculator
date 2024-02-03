import 'package:flutter/material.dart';

class CalculatorHelpers {
  static List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '='
  ];
  static getColor(String text) {
    List<String> operators = ['AC', '(', ')', '/', '*', '+', '-'];
    if (operators.contains(text)) {
      return Colors.grey[800];
    } else if (text == '=') {
      return Colors.deepOrange;
    } else {
      return Colors.grey[900];
    }
  }
}
