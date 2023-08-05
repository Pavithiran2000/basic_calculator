import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _inputText = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'Enter') {
        _calculateResult();
      } else if (buttonText == 'C') {
        _clearInput();
      } else {
        _inputText += buttonText;
      }
    });
  }

  void _calculateResult() {
    try {
      String result = _evaluateExpression(_inputText);
      setState(() {
        _inputText = result;
      });
    } catch (e) {
      setState(() {
        _inputText = 'Error';
      });
    }
  }

  String _evaluateExpression(String expression) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      if (result.isNaN) {
        return 'Error';
      } else {
        return result.toString();
      }
    } catch (e) {
      return 'Error';
    }
  }

  void _clearInput() {
    setState(() {
      _inputText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BASIC FUNCTION CALCULATOR'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[300],
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16.0),
              child: Text(
                _inputText,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('7'),
              _buildNumberButton('8'),
              _buildNumberButton('9'),
              _buildOperatorButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('4'),
              _buildNumberButton('5'),
              _buildNumberButton('6'),
              _buildOperatorButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('1'),
              _buildNumberButton('2'),
              _buildNumberButton('3'),
              _buildOperatorButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNumberButton('0'),
              _buildNumberButton('00'),
              _buildNumberButton('.'),
              _buildOperatorButton('+'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton('C'),
              _buildActionButton('Enter'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String buttonText) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(buttonText),
      child: Text(buttonText),
    );
  }

  Widget _buildOperatorButton(String buttonText) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(buttonText),
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
      ),
    );
  }

  Widget _buildActionButton(String buttonText) {
    return ElevatedButton(
      onPressed: () => _onButtonPressed(buttonText),
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.red),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
      ),
    );
  }
}
