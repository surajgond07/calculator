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
  String equation = '0';
  String result = '';
  String expression = '';
  double equationFontSize = 28.0;
  double resultFontSize = 38.0;

  // Memory Storage
  double memory = 0.0;

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

  Widget buildButton(String buttonText, double buttonHeight, Color bgColor,
      Color buttonColor) {
    buttonPressed(String buttonText) {
      setState(() {
        if (buttonText == 'AC') {
          equation = '0';
          result = '';
          equationFontSize = 28.0;
          resultFontSize = 38.0;
        } else if (buttonText == '⌫') {
          equationFontSize = 28.0;
          resultFontSize = 38.0;
          if (equation.isNotEmpty && equation != '0') {
            equation = equation.substring(0, equation.length - 1);
            if (equation.isEmpty) {
              equation = '0';
              result = '';
            } else {
              _updateResult();
            }
          }
        } else if (buttonText == '=') {
          equationFontSize = 28.0;
          resultFontSize = 38.0;

          expression = equation;
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');
          expression = expression.replaceAll('%', '/100');

          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
            equation = result;
          } catch (e) {
            result = 'Error';
          }
        } else if (buttonText == 'MR') {
          equationFontSize = 28.0;
          resultFontSize = 38.0;
          result = memory.toString();
        } else if (buttonText == 'M+') {
          equationFontSize = 28.0;
          resultFontSize = 38.0;
          memory += double.tryParse(result) ?? 0.0;
        } else if (buttonText == 'M-') {
          equationFontSize = 28.0;
          resultFontSize = 38.0;
          memory -= double.tryParse(result) ?? 0.0;
        } else if (buttonText == 'MC') {
          equationFontSize = 28.0;
          resultFontSize = 38.0;
          memory = 0.0;
        } else {
          equationFontSize = 28.0;
          resultFontSize = 38.0;
          if (equation == '0') {
            equation = buttonText;
          } else {
            equation += buttonText;
          }
          _updateResult();
        }

        // Adjust font size based on equation length
        if (equation.length > 15) {
          equationFontSize = 20.0;
        }
        if (equation.length > 20) {
          equationFontSize = 18.0;
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
          buttonPressed(buttonText);
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
            color: buttonColor,
          ),
        ),
      ),
    );
  }

  void _updateResult() {
    expression = equation;
    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('÷', '/');
    expression = expression.replaceAll('%', '/100');

    // If expression ends with an operator, do not update result
    if (expression.endsWith('+') ||
        expression.endsWith('-') ||
        expression.endsWith('*') ||
        expression.endsWith('/')) {
      result = '';
      return;
    }

    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      result = '${exp.evaluate(EvaluationType.REAL, cm)}';
    } catch (e) {
      result = 'Error';
    }
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
            flex: 3,
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.vertical,
                child: Text(
                  equation,
                  style: TextStyle(fontSize: equationFontSize),
                ),
              ),
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.vertical,
                child: Text(
                  result,
                  style: TextStyle(fontSize: resultFontSize),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  color: Colors.redAccent,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildButton("AC", 1, const Color(0xFF800000),
                              const Color(0xFFFFFFFF)),
                          buildButton("⌫", 1, const Color(0xFF006600),
                              const Color(0xFFFFFFFF)),
                          buildButton("MR", 1, const Color(0xFF195280),
                              const Color(0xFFcccccc)),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("M+", 1, const Color(0xFF195280),
                              const Color(0xFFcccccc)),
                          buildButton("M-", 1, const Color(0xFF195280),
                              const Color(0xFFcccccc)),
                          buildButton("MC", 1, const Color(0xFF195280),
                              const Color(0xFFcccccc)),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("7", 1, const Color(0xE6E6E6E6),
                              const Color(0xFF000000)),
                          buildButton("8", 1, const Color(0xE6E6E6E6),
                              const Color(0xFF000000)),
                          buildButton("9", 1, const Color(0xE6E6E6E6),
                              const Color(0xFF000000)),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("4", 1, const Color(0xE6E6E6E6),
                              const Color(0xFF000000)),
                          buildButton("5", 1, const Color(0xE6E6E6E6),
                              const Color(0xFF000000)),
                          buildButton("6", 1, const Color(0xE6E6E6E6),
                              const Color(0xFF000000)),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("1", 1, const Color(0xE6E6E6E6),
                              const Color(0xFF000000)),
                          buildButton("2", 1, const Color(0xE6E6E6E6),
                              const Color(0xFF000000)),
                          buildButton("3", 1, const Color(0xE6E6E6E6),
                              const Color(0xFF000000)),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("0", 1, const Color(0xE6E6E6E6),
                              const Color(0xFF000000)),
                          buildButton(".", 1, const Color(0xE6E6E6E6),
                              const Color(0xFF000000)),
                          buildButton("%", 1, const Color(0xFF195280),
                              const Color(0xFFcccccc)),
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
                          buildButton("÷", 1, const Color(0xFF195280),
                              const Color(0xFFcccccc)),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("×", 1, const Color(0xFF195280),
                              const Color(0xFFcccccc)),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("-", 1, const Color(0xFF195280),
                              const Color(0xFFcccccc)),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("+", 1, const Color(0xFF195280),
                              const Color(0xFFcccccc)),
                        ],
                      ),
                      TableRow(
                        children: [
                          buildButton("=", 2, const Color(0xFF800000),
                              const Color(0xFFFFFFFF)),
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
