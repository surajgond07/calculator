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

  List<String> equationLines = [];
  String result = '0';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  // Memory Storage
  double memory = 0.0;

  // Method for Button
  Widget buildButton(String buttonText, double buttonHeight, Color bgColor,
      Color buttonColor) {
    // var buttonColor = Colors.white;
    // onPresse method
    buttonPressed(String buttonText) {
      setState(() {
        if (buttonText == 'AC') {
          equationLines.clear();
          result = '0';
        } else if (buttonText == '⌫') {
          if (equationLines.isNotEmpty) {
            equationLines.removeLast();
          }
        } else if (buttonText == '=') {
          try {
            String fullEquation = equationLines.join();
            Parser p = Parser();
            Expression exp = p.parse(fullEquation);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
            equationLines.add('---------------');
            equationLines.add(result);
          } catch (e) {
            result = 'Error';
          }
        } else if (buttonText == 'MR') {
          result = memory.toString();
        } else if (buttonText == 'M+') {
          memory += double.tryParse(result) ?? 0.0;
        } else if (buttonText == 'M-') {
          memory -= double.tryParse(result) ?? 0.0;
        } else if (buttonText == 'MC') {
          memory = 0.0;
        } else {
          if (equationLines.isEmpty) {
            equationLines.add(buttonText);
          } else {
            equationLines.add(buttonText);
          }
        }
      });
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.08 * buttonHeight,
      color: bgColor,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: const BorderSide(
                color: Colors.black,
                width: 0.4,
                style: BorderStyle.solid,
              ),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
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
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: equationLines
                    .map((line) => Text(
                          line,
                          style: TextStyle(
                            fontSize: equationFontSize,
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
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
