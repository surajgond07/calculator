import 'package:flutter/material.dart';
import 'calculator_display.dart';
import 'calculator_button.dart';
import 'calculator_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  final CalculatorLogic calculatorLogic = CalculatorLogic();

  double equationFontSize = 28.0;
  double resultFontSize = 38.0;

  void onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'AC') {
        calculatorLogic.reset();
      } else if (buttonText == '⌫') {
        calculatorLogic.delete();
      } else if (buttonText == '=') {
        calculatorLogic.calculateFinalResult();
      } else if (['+', '-', '×', '÷', '%'].contains(buttonText)) {
        calculatorLogic.isOperatorUsed = true;
        calculatorLogic.isFirstCalculation = false;
        calculatorLogic.equation += buttonText;
        calculatorLogic.result = '';
      } else {
        if (calculatorLogic.equation == '0') {
          calculatorLogic.equation = buttonText;
        } else {
          calculatorLogic.equation += buttonText;
        }
        calculatorLogic.updateResult();
      }

      // Adjust font size based on equation length
      if (calculatorLogic.equation.length > 15) {
        equationFontSize = 20.0;
      }
      if (calculatorLogic.equation.length > 20) {
        equationFontSize = 18.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1f669f),
      ),
      body: Column(
        children: [
          CalculatorDisplay(
            equation: calculatorLogic.equation,
            result: calculatorLogic.result,
            equationFontSize: equationFontSize,
            resultFontSize: resultFontSize,
          ),
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          CalculatorButton(
                            text: "AC",
                            bgColor: const Color(0xFF800000),
                            textColor: const Color(0xFFFFFFFF),
                            onPressed: onButtonPressed,
                          ),
                          CalculatorButton(
                            text: "⌫",
                            bgColor: const Color(0xFF006600),
                            textColor: const Color(0xFFFFFFFF),
                            onPressed: onButtonPressed,
                          ),
                          CalculatorButton(
                            text: "MR",
                            bgColor: const Color(0xFF195280),
                            textColor: const Color(0xFFcccccc),
                            onPressed: onButtonPressed,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalculatorButton(
                            text: "M+",
                            bgColor: const Color(0xFF195280),
                            textColor: const Color(0xFFcccccc),
                            onPressed: onButtonPressed,
                          ),
                          CalculatorButton(
                            text: "M-",
                            bgColor: const Color(0xFF195280),
                            textColor: const Color(0xFFcccccc),
                            onPressed: onButtonPressed,
                          ),
                          CalculatorButton(
                            text: "MC",
                            bgColor: const Color(0xFF195280),
                            textColor: const Color(0xFFcccccc),
                            onPressed: onButtonPressed,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalculatorButton(
                            text: "7",
                            bgColor: const Color(0xE6E6E6E6),
                            textColor: const Color(0xFF000000),
                            onPressed: onButtonPressed,
                          ),
                          CalculatorButton(
                            text: "8",
                            bgColor: const Color(0xE6E6E6E6),
                            textColor: const Color(0xFF000000),
                            onPressed: onButtonPressed,
                          ),
                          CalculatorButton(
                            text: "9",
                            bgColor: const Color(0xE6E6E6E6),
                            textColor: const Color(0xFF000000),
                            onPressed: onButtonPressed,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalculatorButton(
                            text: "4",
                            bgColor: const Color(0xE6E6E6E6),
                            textColor: const Color(0xFF000000),
                            onPressed: onButtonPressed,
                          ),
                          CalculatorButton(
                            text: "5",
                            bgColor: const Color(0xE6E6E6E6),
                            textColor: const Color(0xFF000000),
                            onPressed: onButtonPressed,
                          ),
                          CalculatorButton(
                            text: "6",
                            bgColor: const Color(0xE6E6E6E6),
                            textColor: const Color(0xFF000000),
                            onPressed: onButtonPressed,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalculatorButton(
                            text: "1",
                            bgColor: const Color(0xE6E6E6E6),
                            textColor: const Color(0xFF000000),
                            onPressed: onButtonPressed,
                          ),
                          CalculatorButton(
                            text: "2",
                            bgColor: const Color(0xE6E6E6E6),
                            textColor: const Color(0xFF000000),
                            onPressed: onButtonPressed,
                          ),
                          CalculatorButton(
                            text: "3",
                            bgColor: const Color(0xE6E6E6E6),
                            textColor: const Color(0xFF000000),
                            onPressed: onButtonPressed,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalculatorButton(
                            text: "0",
                            bgColor: const Color(0xE6E6E6E6),
                            textColor: const Color(0xFF000000),
                            onPressed: onButtonPressed,
                          ),
                          CalculatorButton(
                            text: ".",
                            bgColor: const Color(0xE6E6E6E6),
                            textColor: const Color(0xFF000000),
                            onPressed: onButtonPressed,
                          ),
                          CalculatorButton(
                            text: "%",
                            bgColor: const Color(0xFF195280),
                            textColor: const Color(0xFFcccccc),
                            onPressed: onButtonPressed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          CalculatorButton(
                            text: "÷",
                            bgColor: const Color(0xFF195280),
                            textColor: const Color(0xFFcccccc),
                            onPressed: onButtonPressed,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalculatorButton(
                            text: "×",
                            bgColor: const Color(0xFF195280),
                            textColor: const Color(0xFFcccccc),
                            onPressed: onButtonPressed,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalculatorButton(
                            text: "-",
                            bgColor: const Color(0xFF195280),
                            textColor: const Color(0xFFcccccc),
                            onPressed: onButtonPressed,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalculatorButton(
                            text: "+",
                            bgColor: const Color(0xFF195280),
                            textColor: const Color(0xFFcccccc),
                            onPressed: onButtonPressed,
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          CalculatorButton(
                            text: "=",
                            bgColor: const Color(0xFF800000),
                            textColor: const Color(0xFFFFFFFF),
                            onPressed: onButtonPressed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
