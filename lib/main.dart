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

  // Method for Button
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
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
                width: 1,
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
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: const Text(
              '0',
              style: TextStyle(
                fontSize: 38.0,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: const Text(
              '0',
              style: TextStyle(
                fontSize: 48.0,
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
                        // buildButton("AC", 1, const Color(0xFFe62e00)),
                        buildButton("AC", 1, const Color(0xFFcb4d02)),
                        // buildButton("⌫", 1, Colors.blueGrey),
                        buildButton("⌫", 1, const Color(0xFF3e5965)),
                        // buildButton("÷", 1, Colors.blue),
                        // buildButton("÷", 1, const Color(0xFF1f669f)),
                        buildButton("MR", 1, const Color(0xFF1f669f)),
                        // buildButton("÷", 1, const Color(0xFF6c949e)),
                      ],
                    ),
                    TableRow(
                      children: [
                        // unicode symbol
                        // https://www.fileformat.info/info/unicode/category/Sm/list.htm

                        buildButton("M+", 1, const Color(0xFF1f669f)),
                        buildButton("M+", 1, const Color(0xFF1f669f)),
                        buildButton("MC", 1, const Color(0xFF1f669f)),
                      ],
                    ),
                    TableRow(
                      children: [
                        // unicode symbol
                        // https://www.fileformat.info/info/unicode/category/Sm/list.htm
                        buildButton("7", 1, const Color(0xFF808080)),
                        buildButton("8", 1, const Color(0xFF808080)),
                        buildButton("9", 1, const Color(0xFF808080)),
                      ],
                    ),
                    TableRow(
                      children: [
                        // unicode symbol
                        // https://www.fileformat.info/info/unicode/category/Sm/list.htm
                        buildButton("4", 1, const Color(0xFF808080)),
                        buildButton("5", 1, const Color(0xFF808080)),
                        buildButton("6", 1, const Color(0xFF808080)),
                      ],
                    ),
                    TableRow(
                      children: [
                        // unicode symbol
                        // https://www.fileformat.info/info/unicode/category/Sm/list.htm
                        buildButton("1", 1, const Color(0xFF808080)),
                        buildButton("2", 1, const Color(0xFF808080)),
                        buildButton("3", 1, const Color(0xFF808080)),
                      ],
                    ),
                    TableRow(
                      children: [
                        // unicode symbol
                        // https://www.fileformat.info/info/unicode/category/Sm/list.htm
                        buildButton("0", 1, const Color(0xFF808080)),
                        buildButton(".", 1, const Color(0xFF808080)),
                        buildButton("%", 1, const Color(0xFF1f669f)),
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
                      buildButton("÷", 1, const Color(0xFF1f669f)),
                    ]),
                    TableRow(children: [
                      buildButton("×", 1, const Color(0xFF1f669f)),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, const Color(0xFF1f669f)),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, const Color(0xFF1f669f)),
                    ]),
                    TableRow(children: [
                      //https://www.hotsymbol.com/symbol/arrow-pointing-downwards-then-curving-leftwards
                      // buildButton("⁼⟋⤶", 2, const Color(0xFFbc622d)),
                      buildButton("⁼⟋⤶", 2, const Color(0xFFcb4d02)),
                      // buildButton("=", 2, Colors.redAccent),
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
