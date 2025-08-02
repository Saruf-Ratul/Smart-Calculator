import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:intl/intl.dart';

import '../providers/calculator_provider.dart';

class CalculatorDisplay extends StatelessWidget {
  const CalculatorDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, calculator, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Expression display
              if (calculator.expression.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    calculator.expression,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white70
                          : Colors.black54,
                    ),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              
              // Main display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Copy button
                  if (calculator.display != '0' && calculator.display != 'Error')
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        FlutterClipboard.copy(calculator.display);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Result copied to clipboard'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      tooltip: 'Copy to clipboard',
                    ),
                  
                  // Display text
                  Expanded(
                    child: Text(
                      _formatDisplay(calculator.display),
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: _getFontSize(calculator.display),
                      ),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDisplay(String display) {
    if (display == 'Error') return display;
    
    try {
      double number = double.parse(display);
      if (number == number.toInt()) {
        return number.toInt().toString();
      } else {
        // Format to show reasonable number of decimal places
        String formatted = number.toString();
        if (formatted.contains('.')) {
          // Remove trailing zeros after decimal
          formatted = formatted.replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), '');
        }
        return formatted;
      }
    } catch (e) {
      return display;
    }
  }

  double _getFontSize(String display) {
    if (display.length <= 8) return 48;
    if (display.length <= 12) return 36;
    if (display.length <= 16) return 28;
    return 24;
  }
} 