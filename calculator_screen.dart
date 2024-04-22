import 'package:flutter/material.dart';
import 'calculator_button.dart';
import 'calculator_logic.dart';
import 'history_manager.dart';
import 'history_entry.dart';
import 'history_screen.dart'; // Импорт экрана истории

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  CalculatorLogic _calculatorLogic = CalculatorLogic(); // Создание экземпляра CalculatorLogic
  final HistoryManager _historyManager = HistoryManager(); // Создание экземпляра HistoryManager

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '0';
        _calculatorLogic.clear(); // Очистка логики калькулятора
      } else if (buttonText == '=') {
        _output = _calculatorLogic.processInput('='); // Вызов логики калькулятора при нажатии "="

        // Добавление записи в историю при нажатии "="
        _historyManager.addToHistory(_output, double.parse(_output));
      } else {
        _output = _calculatorLogic.processInput(buttonText); // Обработка ввода через логику калькулятора
      }
    });
  }

  void _navigateToConverterScreen(BuildContext context) {
    Navigator.pushNamed(context, '/converter');
  }

  void _navigateToHistoryScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        actions: [
          IconButton(
            onPressed: () => _navigateToHistoryScreen(context),
            icon: Icon(Icons.history),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _output,
              style: TextStyle(fontSize: 48),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton('7', _onButtonPressed),
              CalculatorButton('8', _onButtonPressed),
              CalculatorButton('9', _onButtonPressed),
              CalculatorButton('/', _onButtonPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton('4', _onButtonPressed),
              CalculatorButton('5', _onButtonPressed),
              CalculatorButton('6', _onButtonPressed),
              CalculatorButton('*', _onButtonPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton('1', _onButtonPressed),
              CalculatorButton('2', _onButtonPressed),
              CalculatorButton('3', _onButtonPressed),
              CalculatorButton('-', _onButtonPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton('0', _onButtonPressed),
              CalculatorButton('.', _onButtonPressed),
              CalculatorButton('=', _onButtonPressed),
              CalculatorButton('+', _onButtonPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CalculatorButton('C', _onButtonPressed),
              // Button to navigate to converter screen
              ElevatedButton(
                onPressed: () => _navigateToConverterScreen(context),
                child: Text('Open Converter'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
