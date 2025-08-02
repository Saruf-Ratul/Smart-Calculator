import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'dart:math';
import '../models/calculation_history.dart';

class CalculatorProvider extends ChangeNotifier {
  String _display = '0';
  String _expression = '';
  bool _isScientificMode = false;
  List<CalculationHistory> _history = [];
  bool _isNewCalculation = true;

  String get display => _display;
  String get expression => _expression;
  bool get isScientificMode => _isScientificMode;
  List<CalculationHistory> get history => _history;

  void toggleScientificMode() {
    _isScientificMode = !_isScientificMode;
    notifyListeners();
  }

  void addToHistory(String expression, String result) {
    _history.insert(0, CalculationHistory(
      expression: expression,
      result: result,
      timestamp: DateTime.now(),
    ));
    
    // Keep only last 50 calculations
    if (_history.length > 50) {
      _history = _history.take(50).toList();
    }
    notifyListeners();
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  void inputNumber(String number) {
    Vibrate.feedback(FeedbackType.light);
    
    if (_isNewCalculation) {
      _display = number;
      _expression = number;
      _isNewCalculation = false;
    } else {
      if (_display == '0' && number != '.') {
        _display = number;
        _expression = number;
      } else {
        _display += number;
        _expression += number;
      }
    }
    notifyListeners();
  }

  void inputOperator(String operator) {
    Vibrate.feedback(FeedbackType.light);
    
    if (_expression.isNotEmpty && !_isOperator(_expression[_expression.length - 1])) {
      _expression += operator;
      _display = '0';
    } else if (_expression.isNotEmpty && _isOperator(_expression[_expression.length - 1])) {
      _expression = _expression.substring(0, _expression.length - 1) + operator;
    }
    notifyListeners();
  }

  void inputFunction(String function) {
    Vibrate.feedback(FeedbackType.light);
    
    if (_isNewCalculation) {
      _expression = '$function(';
      _display = '0';
      _isNewCalculation = false;
    } else {
      _expression += '$function(';
      _display = '0';
    }
    notifyListeners();
  }

  void calculate() {
    Vibrate.feedback(FeedbackType.medium);
    
    if (_expression.isEmpty) return;

    try {
      String result = _evaluateExpression(_expression);
      addToHistory(_expression, result);
      _display = result;
      _expression = result;
      _isNewCalculation = true;
    } catch (e) {
      _display = 'Error';
      _expression = '';
      _isNewCalculation = true;
    }
    notifyListeners();
  }

  void clear() {
    Vibrate.feedback(FeedbackType.light);
    _display = '0';
    _expression = '';
    _isNewCalculation = true;
    notifyListeners();
  }

  void delete() {
    Vibrate.feedback(FeedbackType.light);
    if (_display.length > 1) {
      _display = _display.substring(0, _display.length - 1);
      _expression = _expression.substring(0, _expression.length - 1);
    } else {
      _display = '0';
      _expression = '';
      _isNewCalculation = true;
    }
    notifyListeners();
  }

  bool _isOperator(String char) {
    return ['+', '-', '*', '/', '^'].contains(char);
  }

  String _evaluateExpression(String expr) {
    // Handle scientific functions
    expr = _handleScientificFunctions(expr);
    
    // Basic arithmetic evaluation
    return _evaluateBasic(expr);
  }

  String _handleScientificFunctions(String expr) {
    // Handle sin, cos, tan, log, ln, sqrt
    expr = expr.replaceAllMapped(RegExp(r'sin\(([^)]+)\)'), (match) {
      double value = double.parse(_evaluateBasic(match.group(1)!));
      return sin(value).toString();
    });
    
    expr = expr.replaceAllMapped(RegExp(r'cos\(([^)]+)\)'), (match) {
      double value = double.parse(_evaluateBasic(match.group(1)!));
      return cos(value).toString();
    });
    
    expr = expr.replaceAllMapped(RegExp(r'tan\(([^)]+)\)'), (match) {
      double value = double.parse(_evaluateBasic(match.group(1)!));
      return tan(value).toString();
    });
    
    expr = expr.replaceAllMapped(RegExp(r'log\(([^)]+)\)'), (match) {
      double value = double.parse(_evaluateBasic(match.group(1)!));
      return log(value) / ln10.toString();
    });
    
    expr = expr.replaceAllMapped(RegExp(r'ln\(([^)]+)\)'), (match) {
      double value = double.parse(_evaluateBasic(match.group(1)!));
      return log(value).toString();
    });
    
    expr = expr.replaceAllMapped(RegExp(r'sqrt\(([^)]+)\)'), (match) {
      double value = double.parse(_evaluateBasic(match.group(1)!));
      return sqrt(value).toString();
    });
    
    return expr;
  }

  String _evaluateBasic(String expr) {
    // Simple arithmetic evaluation
    // This is a basic implementation - in production, you'd want a more robust parser
    try {
      // Replace ^ with ** for power operation
      expr = expr.replaceAll('^', '**');
      
      // Evaluate the expression
      // Note: This is a simplified approach. For production, consider using a proper expression parser
      return eval(expr).toString();
    } catch (e) {
      throw Exception('Invalid expression');
    }
  }

  double eval(String expression) {
    // Simple expression evaluator
    // This is a basic implementation - consider using packages like 'petitparser' for production
    expression = expression.replaceAll(' ', '');
    
    if (expression.contains('+')) {
      List<String> parts = expression.split('+');
      return parts.map((part) => eval(part)).reduce((a, b) => a + b);
    }
    
    if (expression.contains('-')) {
      List<String> parts = expression.split('-');
      double result = eval(parts[0]);
      for (int i = 1; i < parts.length; i++) {
        result -= eval(parts[i]);
      }
      return result;
    }
    
    if (expression.contains('*')) {
      List<String> parts = expression.split('*');
      return parts.map((part) => eval(part)).reduce((a, b) => a * b);
    }
    
    if (expression.contains('/')) {
      List<String> parts = expression.split('/');
      double result = eval(parts[0]);
      for (int i = 1; i < parts.length; i++) {
        result /= eval(parts[i]);
      }
      return result;
    }
    
    if (expression.contains('**')) {
      List<String> parts = expression.split('**');
      double result = eval(parts[0]);
      for (int i = 1; i < parts.length; i++) {
        result = pow(result, eval(parts[i])).toDouble();
      }
      return result;
    }
    
    return double.parse(expression);
  }
} 