import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculator_provider.dart';

class CalculatorButtons extends StatelessWidget {
  const CalculatorButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // First row: Clear, Delete, Percentage, Divide
          _buildButtonRow([
            _CalculatorButton(
              text: 'C',
              onPressed: () => context.read<CalculatorProvider>().clear(),
              color: Colors.red,
            ),
            _CalculatorButton(
              text: '⌫',
              onPressed: () => context.read<CalculatorProvider>().delete(),
              color: Colors.orange,
            ),
            _CalculatorButton(
              text: '%',
              onPressed: () => context.read<CalculatorProvider>().inputOperator('%'),
            ),
            _CalculatorButton(
              text: '÷',
              onPressed: () => context.read<CalculatorProvider>().inputOperator('/'),
            ),
          ]),
          
          // Second row: 7, 8, 9, Multiply
          _buildButtonRow([
            _CalculatorButton(
              text: '7',
              onPressed: () => context.read<CalculatorProvider>().inputNumber('7'),
            ),
            _CalculatorButton(
              text: '8',
              onPressed: () => context.read<CalculatorProvider>().inputNumber('8'),
            ),
            _CalculatorButton(
              text: '9',
              onPressed: () => context.read<CalculatorProvider>().inputNumber('9'),
            ),
            _CalculatorButton(
              text: '×',
              onPressed: () => context.read<CalculatorProvider>().inputOperator('*'),
            ),
          ]),
          
          // Third row: 4, 5, 6, Subtract
          _buildButtonRow([
            _CalculatorButton(
              text: '4',
              onPressed: () => context.read<CalculatorProvider>().inputNumber('4'),
            ),
            _CalculatorButton(
              text: '5',
              onPressed: () => context.read<CalculatorProvider>().inputNumber('5'),
            ),
            _CalculatorButton(
              text: '6',
              onPressed: () => context.read<CalculatorProvider>().inputNumber('6'),
            ),
            _CalculatorButton(
              text: '-',
              onPressed: () => context.read<CalculatorProvider>().inputOperator('-'),
            ),
          ]),
          
          // Fourth row: 1, 2, 3, Add
          _buildButtonRow([
            _CalculatorButton(
              text: '1',
              onPressed: () => context.read<CalculatorProvider>().inputNumber('1'),
            ),
            _CalculatorButton(
              text: '2',
              onPressed: () => context.read<CalculatorProvider>().inputNumber('2'),
            ),
            _CalculatorButton(
              text: '3',
              onPressed: () => context.read<CalculatorProvider>().inputNumber('3'),
            ),
            _CalculatorButton(
              text: '+',
              onPressed: () => context.read<CalculatorProvider>().inputOperator('+'),
            ),
          ]),
          
          // Fifth row: 0, ., Power, Equals
          _buildButtonRow([
            _CalculatorButton(
              text: '0',
              onPressed: () => context.read<CalculatorProvider>().inputNumber('0'),
              flex: 2,
            ),
            _CalculatorButton(
              text: '.',
              onPressed: () => context.read<CalculatorProvider>().inputNumber('.'),
            ),
            _CalculatorButton(
              text: '^',
              onPressed: () => context.read<CalculatorProvider>().inputOperator('^'),
            ),
            _CalculatorButton(
              text: '=',
              onPressed: () => context.read<CalculatorProvider>().calculate(),
              color: Colors.blue,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<_CalculatorButton> buttons) {
    return Expanded(
      child: Row(
        children: buttons.map((button) => Expanded(
          flex: button.flex,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: button,
          ),
        )).toList(),
      ),
    );
  }
}

class _CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final int flex;

  const _CalculatorButton({
    required this.text,
    required this.onPressed,
    this.color,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2A2A2A)
            : Colors.grey[200],
        foregroundColor: color != null ? Colors.white : Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        padding: const EdgeInsets.all(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
} 