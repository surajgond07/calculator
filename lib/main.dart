import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
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
  // To lock the HomeScreen to portrait mode only
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  // Method for Button
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    // onPresse method
    buttonPressed(String button) {
      setState(() {
        if (buttonText == 'AC') {
          equation = '0';
          result = '0';
        } else if (buttonText == '⌫') {
          if (equation.isNotEmpty && equation != '0') {
            equation = equation.substring(0, equation.length - 1);
            if (equation.isEmpty) {
              equation = '0';
            }
          }
        } else if (buttonText == '=') {
        } else {
          if (equation == '0') {
            equation = buttonText;
          } else {
            equation = equation + buttonText;
          }
        }
      });
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.08 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: const BorderSide(
                color: Colors.white,
                width: 0.4,
                style: BorderStyle.solid,
              ),
            ),
          ),
          padding: WidgetStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(16.0),
          ),
        ),
        onPressed: () {
          // on press logic
          buttonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1f669f),
      ),
      body: Column(
        children: [
          // Equation container
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(
                fontSize: equationFontSize,
              ),
            ),
          ),
          // Result Container
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                fontSize: resultFontSize,
              ),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                color: Colors.redAccent,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        // unicode symbol
                        // https://www.fileformat.info/info/unicode/category/Sm/list.htm
                        //https://www.hotsymbol.com/symbol/arrow-pointing-downwards-then-curving-leftwards

                        buildButton("AC", 1, const Color(0xFF800000)),

                        buildButton("⌫", 1, const Color(0xFF006600)),

                        buildButton("MR", 1, const Color(0xFF195280)),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("M+", 1, const Color(0xFF195280)),
                        buildButton("M+", 1, const Color(0xFF195280)),
                        buildButton("MC", 1, const Color(0xFF195280)),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, const Color(0xFF808080)),
                        buildButton("8", 1, const Color(0xFF808080)),
                        buildButton("9", 1, const Color(0xFF808080)),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, const Color(0xFF808080)),
                        buildButton("5", 1, const Color(0xFF808080)),
                        buildButton("6", 1, const Color(0xFF808080)),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, const Color(0xFF808080)),
                        buildButton("2", 1, const Color(0xFF808080)),
                        buildButton("3", 1, const Color(0xFF808080)),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("0", 1, const Color(0xFF808080)),
                        buildButton(".", 1, const Color(0xFF808080)),
                        buildButton("%", 1, const Color(0xFF195280)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("÷", 1, const Color(0xFF195280)),
                    ]),
                    TableRow(children: [
                      buildButton("×", 1, const Color(0xFF195280)),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, const Color(0xFF195280)),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, const Color(0xFF195280)),
                    ]),
                    TableRow(children: [
                      buildButton("⁼⟋⤶", 2, const Color(0xFF800000)),
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
