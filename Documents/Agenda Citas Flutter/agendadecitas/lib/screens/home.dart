import 'package:agendacitas/screens/calendarioScreen.dart';
import 'package:agendacitas/screens/cientesScreen.dart';
import 'package:flutter/material.dart';

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
    return MaterialApp(title: _title, home: MyStatefulWidget(), routes: {
      'clientaStep': (BuildContext context) => ClientaStep(),
      'servicioStep': (BuildContext context) => ServicioStep(),
      'citaStep': (BuildContext context) => CitaStep(),
      'confirmarStep': (BuildContext context) => ConfirmarStep(),
      'configScreen': (BuildContext context) => ConfigScreen(),
      'Servicios': (BuildContext context) => ConfigServiciosScreen(),
      'clientesScreen': (_) => ClientesScreen(),
    });
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
  static List<Widget> _widgetOptions = <Widget>[
    CalendarioCitasScreen(),
    ClientesScreen(),
    ConfigScreen(),
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
            icon: Icon(Icons.settings),
            label: 'Config',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
