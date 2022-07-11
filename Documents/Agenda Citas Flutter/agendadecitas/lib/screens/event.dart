import 'package:agendacitas/models/cita_model.dart';
import 'package:flutter/material.dart';

void main() => runApp(EventCalendar());

class EventCalendar extends StatefulWidget {
  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {


  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}

Widget verTodasCitas(context, citasprovider) {
  return FutureBuilder(
      future: citasprovider.cargarCitas(),
      builder: (context, snapshot) {
        List<CitaModel> citas = snapshot.data as List<CitaModel>;

        if (snapshot.hasData) Center(child: CircularProgressIndicator());

        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: citas.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: Text(citas[index].manospies.toString()),
                    trailing: Text(
                      citas[index].id.toString(),
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                    title: Text("Clienta: ${citas[index].nombre}"));
              });
        } else {
          return Text('sin datos');
        }
      });
}