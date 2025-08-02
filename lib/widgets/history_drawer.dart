import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:intl/intl.dart';

import '../providers/calculator_provider.dart';

class HistoryDrawer extends StatelessWidget {
  const HistoryDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Center(
              child: Text(
                'Calculation History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<CalculatorProvider>(
              builder: (context, calculator, child) {
                if (calculator.history.isEmpty) {
                  return const Center(
                    child: Text(
                      'No calculations yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: calculator.history.length,
                  itemBuilder: (context, index) {
                    final historyItem = calculator.history[index];
                    return _HistoryItem(
                      historyItem: historyItem,
                      onTap: () {
                        // Copy result to clipboard
                        FlutterClipboard.copy(historyItem.result);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${historyItem.result} copied to clipboard'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Consumer<CalculatorProvider>(
            builder: (context, calculator, child) {
              if (calculator.history.isEmpty) return const SizedBox.shrink();
              
              return Container(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      calculator.clearHistory();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('History cleared'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Clear History'),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final dynamic historyItem;
  final VoidCallback onTap;

  const _HistoryItem({
    required this.historyItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        onTap: onTap,
        title: Text(
          historyItem.expression,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '= ${historyItem.result}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              DateFormat('MMM dd, HH:mm').format(historyItem.timestamp),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.copy),
      ),
    );
  }
} 