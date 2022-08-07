import 'package:agendacitas/widgets/change_theme_button.dart';
import 'package:flutter/material.dart';

class TemaScreen extends StatefulWidget {
  TemaScreen({Key? key}) : super(key: key);

  @override
  State<TemaScreen> createState() => _TemaScreenState();
}

class _TemaScreenState extends State<TemaScreen> {
  bool _giveVerse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tema'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Dark/Light'), ChangeThemeButtonWidget()],
            )
          ],
        ),
      ),
    );
  }
}
