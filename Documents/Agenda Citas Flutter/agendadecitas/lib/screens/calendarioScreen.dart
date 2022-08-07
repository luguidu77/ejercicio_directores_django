import 'package:agendacitas/providers/cita_list_provider.dart';

import 'package:agendacitas/utils/formatear.dart';
import 'package:agendacitas/widgets/change_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:intl/intl.dart';

class CalendarioCitasScreen extends StatefulWidget {
  const CalendarioCitasScreen({Key? key}) : super(key: key);

  @override
  State<CalendarioCitasScreen> createState() => _CalendarioCitasScreenState();
}

class _CalendarioCitasScreenState extends State<CalendarioCitasScreen> {
  Color colorBotonFlecha = Colors.amber;
  List<Map<String, dynamic>> citas = [];
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  int preciototal = 0;
  bool ocultarPrecios = true;
  Icon reloj = Icon(Icons.ac_unit);

  leerBasedatos() async {
    var fecha = dateFormat.format(fechaElegida);
    citas = await CitaListProvider().cargarCitasPorFecha(fecha);
    List<Map<String, dynamic>> datestrings = [];

    citas.sort((a, b) {
      //sorting in ascending order
      return DateTime.parse(a['horaInicio'])
          .compareTo(DateTime.parse(b['horaInicio']));
    });

    await precioTotal(citas);
    setState(() {});
  }

  precioTotal(_cita) {
    preciototal = 0;
    for (var i = 0; i < _cita.length; i++) {
      preciototal = preciototal + int.parse(_cita[i]['precio'].toString());
    }
  }

  DateFormat formatDay = DateFormat('EEE dd-MM', 'es_ES');
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
      drawer: menuDrawer(),
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
            child: (citas.isEmpty)
                ? const Text('no hay citas')
                : ListView.builder(
                    itemCount: citas.length,
                    itemBuilder: (BuildContext context, int index) {
                      String _horaInicio = FormatearFechaHora()
                          .formatearHora(citas[index]['horaInicio'].toString());
                      String _horaFinal = FormatearFechaHora()
                          .formatearHora(citas[index]['horaFinal'].toString());

                      var horainiciocita =
                          DateTime.parse(citas[index]['horaInicio']);

                      if (horainiciocita.isAfter(DateTime.now())) {
                        reloj = const Icon(Icons.watch_rounded);
                      } else {
                        reloj = const Icon(Icons.lock_clock_outlined);
                      }

                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                          child: Row(
                            children: const [
                              SizedBox(width: 15.0),
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        key: GlobalKey(),
                        onDismissed: (direction) {
                          _mensajeAlerta(context, index);
                        },
                        child: Card(
                            child: Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 60,
                                  child: Card(
                                    //color: (Colors.grey[50]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        reloj, // icono cambia si cita realizada o a realizar
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                        )),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _mensajeAlerta(BuildContext context, int index) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Icon(
                Icons.warning,
                color: Colors.red,
              ),
              content: Text(
                  '¿ Quieres eliminar la cita de ${citas[index]['nombre']}?'),
              actions: [
                TextButton(
                    onPressed: () {
                      _eliminarCita(citas[index]['id'], citas[index]['nombre']);

                      Navigator.pop(context);
                    },
                    child: const Text(
                      ' Sí, eliminar ',
                      style: TextStyle(
                          fontSize: 18,
                          backgroundColor: Colors.red,
                          color: Colors.white),
                    )),
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: const Text(
                      ' No ',
                      style: TextStyle(fontSize: 18),
                    )),
              ],
            ));
  }

  menuDrawer() {
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
            leading: const Icon(Icons.format_paint_sharp),
            title: Row(
              children: [const Text('Dark / Light'), ChangeThemeButtonWidget()],
            ),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              Navigator.pushNamed(context, 'configScreen');
            },
          ),
        ],
      ),
    );
  }

  void _eliminarCita(int id, String nombreClienta) async {
    await CitaListProvider().elimarCita(id);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Cita Eliminada $nombreClienta')));
  }
}
