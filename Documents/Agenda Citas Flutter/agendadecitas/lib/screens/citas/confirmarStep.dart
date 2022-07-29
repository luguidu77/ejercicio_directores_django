import 'package:agendacitas/models/cita_model.dart';
import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(88.0),
        child: Column(
          children: [
            Column(
              children: [
                Text(clienta['NOMBRE']),
                Text(clienta['TELEFONO']),
                Text(servicio['SERVICIO']),
                Text(servicio['PRECIO']),
                Text(citaFechaHora['FECHA']),
                Text('hora inicio $textoHoraInicio'),
                Text('hora inicio $textoHoraFinal'),
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
                        child: Text('grabar')),
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

    Navigator.pushNamed(context, '/');
  }
}
