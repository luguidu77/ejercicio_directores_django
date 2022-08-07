import 'package:agendacitas/models/cita_model.dart';
import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConfirmarStep extends StatefulWidget {
  ConfirmarStep({Key? key}) : super(key: key);

  @override
  State<ConfirmarStep> createState() => _ConfirmarStepState();
}

class _ConfirmarStepState extends State<ConfirmarStep> {
  @override
  void initState() {
    super.initState();

    // _askPermissions('/nuevacita');
  }

  @override
  Widget build(BuildContext context) {
    var citaElegida = Provider.of<CitaListProvider>(context);

    var clienta = citaElegida.getClientaElegida;
    var servicio = citaElegida.getServicioElegido;
    var citaFechaHora = citaElegida.getCitaElegida;

    var fecha = DateTime.parse(citaFechaHora['FECHA'])
            .day
            .toString()
            .padLeft(2, '0') +
        '/' +
        DateTime.parse(citaFechaHora['FECHA']).month.toString().padLeft(2, '0');

    //todo: pasar por la clase formater hora y fecha
    var textoHoraInicio = DateTime.parse(citaFechaHora['HORAINICIO'].toString())
            .hour
            .toString()
            .padLeft(2, '0') +
        ':' +
        DateTime.parse(citaFechaHora['HORAINICIO'].toString())
            .minute
            .toString()
            .padLeft(2, '0');
    var textoHoraFinal = DateTime.parse(citaFechaHora['HORAFINAL'].toString())
            .hour
            .toString()
            .padLeft(2, '0') +
        ':' +
        DateTime.parse(citaFechaHora['HORAFINAL'].toString())
            .minute
            .toString()
            .padLeft(2, '0');

    print(textoHoraInicio);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/'),
              icon: const Icon(Icons.cancel_outlined, color: Colors.amber),
              label:
                  const Text('Cancelar', style: TextStyle(color: Colors.amber)),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(88.0),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.face),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(clienta['NOMBRE']),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.phone),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(clienta['TELEFONO']),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.design_services),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(servicio['SERVICIO']),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.euro),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(servicio['PRECIO']),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.date_range_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(fecha),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.watch),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        Text(textoHoraInicio),
                        Text(textoHoraFinal),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: //todo: boton de pueba graba la cita
                    TextButton(
                        onPressed: () => grabarCita(
                              context,
                              citaElegida,
                              citaFechaHora['FECHA'].toString(),
                              citaFechaHora['HORAINICIO'].toString(),
                              citaFechaHora['HORAFINAL'].toString(),
                              'comentario',
                              int.parse(clienta['ID'].toString()),
                              int.parse(servicio['ID'].toString()),
                            ),
                        child: const Text('CONFIRMAR CITA')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  grabarCita(
    context,
    CitaListProvider citaElegida,
    String fecha,
    String horaInicio,
    String horaFinal,
    String comentario,
    int idCliente,
    int idServicio,
  ) async {
    var cita = await citaElegida.nuevaCita(
      fecha,
      horaInicio,
      horaFinal,
      comentario,
      idCliente,
      idServicio,
    );

    //todo: alerta para compartir por whatsapp
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Icon(
                Icons.auto_fix_normal_sharp,
                color: Colors.red,
              ),
              content: const Text('Cita creada correctamente'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/'),
                    child: const Text('Omitir')),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {}, child: const Text('Compartir')),
                  ],
                )
              ],
            ));
    // Navigator.pushNamed(context, '/');
  }
}
