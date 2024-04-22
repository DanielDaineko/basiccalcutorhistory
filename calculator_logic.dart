import 'history_manager.dart';

class CalculatorLogic {
  final HistoryManager historyManager = HistoryManager();

  double _buffer = 0.0;
  String _currentOperator = '';
  double _result = 0.0;

  String processInput(String input) {
    if (input == 'C') {
      _clear();
    } else if (input == '=') {
      return _calculate();
    } else if (_isOperator(input)) {
      _handleOperator(input);
    } else {
      _appendToBuffer(input);
    }

    return _formatOutput(_buffer);
  }

  bool _isOperator(String value) {
    return ['+', '-', '*', '/'].contains(value);
  }

  void _appendToBuffer(String value) {
    if (_buffer == 0.0 || _buffer == null) {
      _buffer = double.parse(value);
    } else {
      _buffer = double.parse('$_buffer$value');
    }
  }

  void _handleOperator(String operator) {
    if (_currentOperator != '') {
      _calculate();
    }

    _currentOperator = operator;
    _result = _buffer;
    _buffer = 0.0;
  }

  String _calculate() {
    if (_currentOperator != '') {
      switch (_currentOperator) {
        case '+':
          _result += _buffer;
          break;
        case '-':
          _result -= _buffer;
          break;
        case '*':
          _result *= _buffer;
          break;
        case '/':
          if (_buffer != 0) {
            _result /= _buffer;
          } else {
            _buffer = double.nan;
            return 'Error';
          }
          break;
      }

      String result = _formatOutput(_result);
      // Добавление записи в историю
      historyManager.addToHistory('$_result $_currentOperator $_buffer = $result', _result);

      _buffer = _result;
      _currentOperator = '';
      return result;
    }
    return '';
  }

  void _clear() {
    _buffer = 0.0;
    _currentOperator = '';
    _result = 0.0;
  }

  String _formatOutput(double value) {
    String formattedOutput = value.toStringAsFixed(2);
    if (formattedOutput.endsWith('.00')) {
      return value.toInt().toString();
    }
    return formattedOutput;
  }

  void clear() {}
}
