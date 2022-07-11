
import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:agendacitas/screens/calendar.dart';
import 'package:agendacitas/screens/citaScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() => initializeDateFormatting().then((_)=>runApp(const MyApp()));

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
         ChangeNotifierProvider(create: (BuildContext context)=>  CitaListProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: '/',
          routes: {
            
            '/': (_) => const CalendarScreen(),
            'nuevacita': (BuildContext context) =>  CitaScreen(),
          }),
    );
  }
}
