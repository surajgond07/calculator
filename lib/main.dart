import 'package:flutter/material.dart';

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
  // Method for Button
  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
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
            fontSize: 30.0,
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
        backgroundColor: Colors.blue,
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
                          buildButton("C", 1, Colors.redAccent),
                          buildButton("⌫", 1, Colors.blue),
                          buildButton("÷", 1, Colors.blue),
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
                          buildButton(".", 1, const Color(0xFF808080)),
                          buildButton("0", 1, const Color(0xFF808080)),
                          buildButton("00", 1, const Color(0xFF808080)),
                        ],
                      ),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
