import 'package:flutter/material.dart';

// Display widget for the calculator
class CalculatorDisplay extends StatelessWidget {
  final String equation;
  final String result;
  final double equationFontSize;
  final double resultFontSize;

  const CalculatorDisplay({
    super.key,
    required this.equation,
    required this.result,
    required this.equationFontSize,
    required this.resultFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}

// // Button widget for the calculator
// class CalculatorButton extends StatelessWidget {
//   final String text;
//   final Color bgColor;
//   final Color textColor;
//   final Function onPressed;

//   const CalculatorButton({
//     super.key,
//     required this.text,
//     required this.bgColor,
//     required this.textColor,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: bgColor,
//       child: TextButton(
//         onPressed: () => onPressed(text),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 20.0,
//             color: textColor,
//           ),
//         ),
//       ),
//     );
//   }
// }


