import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:agendacitas/providers/theme_provider.dart';

import 'package:agendacitas/screens/home.dart';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
//https://github.com/luguidu77/agendaCitas.git

void main() => initializeDateFormatting().then((_) => runApp(const MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => CitaListProvider()),
        ChangeNotifierProvider(
            create: (BuildContext context) => ThemeProvider()),
      ],
      builder: (context, _) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            initialRoute: '/',
            routes: {
              '/': (BuildContext context) => const HomeScreen(),
            });
      },
    );
  }
}
