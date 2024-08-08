import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

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
  String finalResult = '0';
  String expression = '';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  // Memory Storage
  double memory = 0.0;

  // Method for Button
  Widget buildButton(String buttonText, double buttonHeight, Color bgColor,
      Color buttonColor) {
    // var buttonColor = Colors.white;
    // onPresse method
    buttonPressed(String button) {
      setState(() {
        if (buttonText == 'AC') {
          equation = '0';
          result = '0';
          equationFontSize = 38.0;
          resultFontSize = 48.0;
        } else if (buttonText == '⌫') {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          if (equation.isNotEmpty && equation != '0') {
            equation = equation.substring(0, equation.length - 1);
            if (equation.isEmpty) {
              equation = '0';
            }
          }
        } else if (buttonText == '=') {
          equationFontSize = 38.0;
          resultFontSize = 48.0;

          expression = equation;
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');
          expression = expression.replaceAll('%', '/ 100');

          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
            finalResult = result;
            // Clear the equation after evaluation
            equation = finalResult; // or equation = "0";
          } catch (e) {
            result = 'Error';
          }
          // Add Memory storage function
        } else if (buttonText == 'MR') {
          equationFontSize = 38.0;
          resultFontSize = 48.0;
          result = memory.toString();
        } else if (buttonText == 'M+') {
          equationFontSize = 38.0;
          resultFontSize = 48.0;
          memory += double.tryParse(result) ?? 0.0;
        } else if (buttonText == 'M-') {
          equationFontSize = 38.0;
          resultFontSize = 48.0;
          memory -= double.tryParse(result) ?? 0.0;
        } else if (buttonText == 'MC') {
          equationFontSize = 38.0;
          resultFontSize = 48.0;
          memory = 0.0;
        } else {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
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
      color: bgColor,
      child: TextButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: const BorderSide(
                // Button Border Color
                color: Colors.black,
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
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.normal,
            color: buttonColor,
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
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: const TextStyle(
                fontSize: 25.0,
              ),
            ),
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

                        buildButton(
                          "AC",
                          1,
                          const Color(0xFF800000),
                          const Color(0xFFFFFFFF),
                        ),

                        buildButton(
                          "⌫",
                          1,
                          const Color(0xFF006600),
                          const Color(0xFFFFFFFF),
                        ),

                        buildButton(
                          "MR",
                          1,
                          const Color(0xFF195280),
                          const Color(0xFFcccccc),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(
                          "M+",
                          1,
                          const Color(0xFF195280),
                          const Color(0xFFcccccc),
                        ),
                        buildButton(
                          "M-",
                          1,
                          const Color(0xFF195280),
                          const Color(0xFFcccccc),
                        ),
                        buildButton(
                          "MC",
                          1,
                          const Color(0xFF195280),
                          const Color(0xFFcccccc),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(
                          "7",
                          1,
                          const Color(0xE6E6E6E6),
                          const Color(0xFF000000),
                        ),
                        buildButton(
                          "8",
                          1,
                          const Color(0xE6E6E6E6),
                          const Color(0xFF000000),
                        ),
                        buildButton(
                          "9",
                          1,
                          const Color(0xE6E6E6E6),
                          const Color(0xFF000000),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(
                          "4",
                          1,
                          const Color(0xE6E6E6E6),
                          const Color(0xFF000000),
                        ),
                        buildButton(
                          "5",
                          1,
                          const Color(0xE6E6E6E6),
                          const Color(0xFF000000),
                        ),
                        buildButton(
                          "6",
                          1,
                          const Color(0xE6E6E6E6),
                          const Color(0xFF000000),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(
                          "1",
                          1,
                          const Color(0xE6E6E6E6),
                          const Color(0xFF000000),
                        ),
                        buildButton(
                          "2",
                          1,
                          const Color(0xE6E6E6E6),
                          const Color(0xFF000000),
                        ),
                        buildButton(
                          "3",
                          1,
                          const Color(0xE6E6E6E6),
                          const Color(0xFF000000),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton(
                          "0",
                          1,
                          const Color(0xE6E6E6E6),
                          const Color(0xFF000000),
                        ),
                        buildButton(
                          ".",
                          1,
                          const Color(0xE6E6E6E6),
                          const Color(0xFF000000),
                        ),
                        buildButton(
                          "%",
                          1,
                          const Color(0xFF195280),
                          const Color(0xFFcccccc),
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
                    TableRow(children: [
                      buildButton(
                        "÷",
                        1,
                        const Color(0xFF195280),
                        const Color(0xFFcccccc),
                      ),
                    ]),
                    TableRow(children: [
                      buildButton(
                        "×",
                        1,
                        const Color(0xFF195280),
                        const Color(0xFFcccccc),
                      ),
                    ]),
                    TableRow(children: [
                      buildButton(
                        "-",
                        1,
                        const Color(0xFF195280),
                        const Color(0xFFcccccc),
                      ),
                    ]),
                    TableRow(children: [
                      buildButton(
                        "+",
                        1,
                        const Color(0xFF195280),
                        const Color(0xFFcccccc),
                      ),
                    ]),
                    TableRow(children: [
                      // buildButton("⁼⟋⤶", 2, const Color(0xFF800000), const Color(0xFFFFFFFF),),
                      buildButton(
                        "=",
                        2,
                        const Color(0xFF800000),
                        const Color(0xFFFFFFFF),
                      ),
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
