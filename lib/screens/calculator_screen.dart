import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../providers/calculator_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/ads_provider.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_buttons.dart';
import '../widgets/scientific_buttons.dart';
import '../widgets/history_drawer.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdsProvider>().loadBannerAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartCalc'),
        actions: [
          Consumer<CalculatorProvider>(
            builder: (context, calculator, child) {
              return IconButton(
                icon: Icon(
                  calculator.isScientificMode ? Icons.science : Icons.calculate,
                ),
                onPressed: () => calculator.toggleScientificMode(),
                tooltip: 'Toggle Scientific Mode',
              );
            },
          ),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () => themeProvider.toggleTheme(),
                tooltip: 'Toggle Theme',
              );
            },
          ),
        ],
      ),
      drawer: const HistoryDrawer(),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const CalculatorDisplay(),
                Expanded(
                  child: Consumer<CalculatorProvider>(
                    builder: (context, calculator, child) {
                      return calculator.isScientificMode
                          ? const ScientificButtons()
                          : const CalculatorButtons();
                    },
                  ),
                ),
              ],
            ),
          ),
          Consumer<AdsProvider>(
            builder: (context, adsProvider, child) {
              if (adsProvider.isPremium || !adsProvider.isAdLoaded) {
                return const SizedBox.shrink();
              }
              return Container(
                height: 50,
                width: double.infinity,
                child: AdWidget(ad: adsProvider.bannerAd!),
              );
            },
          ),
        ],
      ),
    );
  }
} 