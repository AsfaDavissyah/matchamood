import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'page/home_page.dart';
// import 'package:provider/provider.dart';

void main() {
  runApp(const MatchaMoodApp());
}

class MatchaMoodApp extends StatelessWidget {
  const MatchaMoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MatchaMood',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
