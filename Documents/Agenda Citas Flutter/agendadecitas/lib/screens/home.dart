import 'package:agendacitas/providers/theme_provider.dart';
import 'package:agendacitas/screens/calendarioScreen.dart';
import 'package:agendacitas/screens/cientesScreen.dart';
import 'package:agendacitas/screens/config/temaScreen.dart';
import 'package:agendacitas/screens/informesScreen.dart';
import 'package:agendacitas/screens/serviciosScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'citas/citaStep.dart';
import 'citas/clientaStep.dart';
import 'citas/confirmarStep.dart';
import 'citas/servicioStep.dart';
import 'config/cofigScreen.dart';
import 'config/configServiciosScreen.dart';

void main() => runApp(const HomeScreen());

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      themeMode: themeProvider.themeMode,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      home: const MyStatefulWidget(),
      routes: {
        'clientaStep': (BuildContext context) => ClientaStep(),
        'servicioStep': (BuildContext context) => ServicioStep(),
        'citaStep': (BuildContext context) => CitaStep(),
        'confirmarStep': (BuildContext context) => ConfirmarStep(),
        'configScreen': (BuildContext context) => ConfigScreen(),
        'clientesScreen': (_) => ClientesScreen(),
        'calendarioScreen': (BuildContext context) => CalendarioCitasScreen(),
        'Tema': (BuildContext context) => TemaScreen(),
        'configServicios': (BuildContext context) => ConfigServiciosScreen(),
        'Servicios': (_) => ServiciosScreen(),
        'informesScreen': (_) => InformesScreen(),
      },
      /*  ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ), */
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = [
    CalendarioCitasScreen(),
    ClientesScreen(),
    InformesScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'HOY',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face_sharp),
            label: 'Clientes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_repair_service_outlined),
            label: 'Informes',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
