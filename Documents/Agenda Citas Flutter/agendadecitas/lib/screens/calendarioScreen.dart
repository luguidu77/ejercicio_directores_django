import 'dart:math';

import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:agendacitas/providers/db_provider.dart';
import 'package:agendacitas/utils/formatear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalendarioCitasScreen extends StatefulWidget {
  CalendarioCitasScreen({Key? key}) : super(key: key);

  @override
  State<CalendarioCitasScreen> createState() => _CalendarioCitasScreenState();
}

class _CalendarioCitasScreenState extends State<CalendarioCitasScreen> {
  Color colorBotonFlecha = Colors.amber;
  List<Map<String, dynamic>> citas = [];
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  int preciototal = 0;
  bool ocultarPrecios = true;

  leerBasedatos() async {
    var fecha = dateFormat.format(fechaElegida);
    citas = await CitaListProvider().cargarCitasPorFecha(fecha);
    //print(citas);
    await precioTotal(citas);
    setState(() {});
  }

  precioTotal(_cita) {
    preciototal = 0;
    for (var i = 0; i < _cita.length; i++) {
      preciototal = preciototal + int.parse(_cita[i]['precio'].toString());
    }
  }

  DateFormat formatDay = DateFormat('dd-MM');
  DateTime fechaElegida = DateTime.now();
  String fechaTexto = '';

  @override
  void initState() {
    fechaTexto = formatDay.format(fechaElegida);
    leerBasedatos();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<ClienteModel> nombreCliente = clientes();
    DateTime initialDate = DateTime.now();
    DateTime firstDate = initialDate.subtract(const Duration(days: 30));
    DateTime lastDate = initialDate.add(const Duration(days: 30));

    return Scaffold(
      drawer: menu(),
      appBar: AppBar(
        title: const Text(
            'Hoy'), /* actions: [IconButton(onPressed: ()=>Navigator.pushNamed(context, 'calendar'), icon: Icon(Icons.calendar_today))] */
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'clientaStep'),
        child: const Icon(Icons.plus_one_outlined),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => {
                    setState(() {
                      fechaTexto = formatDay.format(
                          fechaElegida.subtract(const Duration(days: 1)));
                      fechaElegida =
                          fechaElegida.subtract(const Duration(days: 1));
                      leerBasedatos();
                    })
                  },
                  icon: const Icon(Icons.arrow_left_outlined),
                  iconSize: 50,
                  color: colorBotonFlecha,
                ),
                GestureDetector(
                  onTap: () => showMaterialDatePicker(
                      context: context,
                      title: 'Buscar Citas',
                      
                      selectedDate: initialDate,
                      firstDate: firstDate,
                      lastDate: lastDate,
                      onChanged: (value) {
                        setState(() {
                          fechaTexto = formatDay.format(value);
                          fechaElegida = (value);
                          leerBasedatos();
                        });
                      }),
                  child: Text(
                    fechaTexto,
                    style: const TextStyle(fontSize: 22.0),
                  ),
                ),
                IconButton(
                  onPressed: () => {
                    setState(() {
                      fechaTexto = formatDay
                          .format(fechaElegida.add(const Duration(days: 1)));
                      fechaElegida = fechaElegida.add(const Duration(days: 1));
                      leerBasedatos();
                    })
                  },
                  icon: const Icon(Icons.arrow_right_outlined),
                  iconSize: 50,
                  color: colorBotonFlecha,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                    onPressed: () {
                      ocultarPrecios = !ocultarPrecios;

                      setState(() {});
                    },
                    icon: ocultarPrecios
                        ? const Icon(Icons.visibility_sharp)
                        : const Icon(Icons.visibility_off),
                    label: const Text('')),
                Text(ocultarPrecios ? '***' : preciototal.toString()),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: (citas.length == 0)
                ? const Text('no hay citas')
                : ListView.builder(
                    itemCount: citas.length,
                    itemBuilder: (BuildContext context, int index) {
                      String _horaInicio = FormatearFechaHora()
                          .formatearHora(citas[index]['horaInicio'].toString());
                      String _horaFinal = FormatearFechaHora()
                          .formatearHora(citas[index]['horaFinal'].toString());

                      return Card(
                          child: Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 60,
                                child: Card(
                                  color: (Colors.amber[50]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(Icons
                                          .watch_outlined), //todo:watch y watch_outlined , si cita realizada o a realizar
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(_horaInicio),
                                          Text(_horaFinal),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //? NOMBRE CLIENTA Y SERVICIO
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 195,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(citas[index]['nombre'].toString()),
                                    Text(citas[index]['servicio'].toString())
                                  ],
                                ),
                              ),
                              Text(
                                ocultarPrecios
                                    ? '***'
                                    : citas[index]['precio'].toString(),
                                textAlign: TextAlign.right,
                              )
                            ],
                          )
                        ],
                      ));
                    },
                  ),
          ),
        ],
      ),
    );
  }

  menu() {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Agenda Citas'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Configuración'),
            onTap: () {
              Navigator.pushNamed(context, 'configScreen');
            },
          ),
        ],
      ),
    );
  }
}
