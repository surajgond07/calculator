import 'package:math_expressions/math_expressions.dart';

class CalculatorLogic {
  String equation = '0';
  String result = '';
  bool isOperatorUsed = false;
  bool isFirstCalculation = true;

  void reset() {
    equation = '0';
    result = '';
    isOperatorUsed = false;
    isFirstCalculation = true;
  }

  void delete() {
    if (equation.isNotEmpty && equation != '0') {
      equation = equation.substring(0, equation.length - 1);
      if (equation.isEmpty) {
        reset();
      } else {
        updateResult();
      }
    }
  }

  void updateResult() {
    if (isFirstCalculation || !isOperatorUsed) {
      String expression = equation
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('%', '/100');
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        result = eval.toStringAsFixed(eval.truncateToDouble() == eval ? 0 : 3);
      } catch (e) {
        result = 'Error';
      }
    }
  }

  void calculateFinalResult() {
    String expression = equation
        .replaceAll('×', '*')
        .replaceAll('÷', '/')
        .replaceAll('%', '/100');
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      result = eval.toStringAsFixed(eval.truncateToDouble() == eval ? 0 : 3);
      equation = result;
    } catch (e) {
      result = 'Error';
    }
  }
}
