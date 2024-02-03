import 'package:calculator/helpers.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(fontSize: 48, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
                itemCount: CalculatorHelpers.buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (BuildContext context, int index) {
                  return customButton(CalculatorHelpers.buttonList[index]);
                }),
          ))
        ],
      ),
    );
  }

  Widget customButton(String text) {
    return InkWell(
      splashColor: CalculatorHelpers.getColor(text),
      borderRadius: BorderRadius.circular(45),
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
          decoration: BoxDecoration(
            color: CalculatorHelpers.getColor(text),
            borderRadius: BorderRadius.circular(45),
          ),
          child: Center(
            child: Text(
              text == "*" ? "x" : text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          )),
    );
  }

  handleButtons(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    } else if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    } else if (text == "=") {
      result = calculate();
      userInput = result;
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }
    } else {
      userInput = userInput + text;
    }
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
