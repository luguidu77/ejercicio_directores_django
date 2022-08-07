import 'package:agendacitas/models/cita_model.dart';
import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:agendacitas/providers/my_detail_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:intl/intl.dart';

class ConfigServiciosScreen extends StatefulWidget {
  ConfigServiciosScreen({Key? key}) : super(key: key);

  @override
  State<ConfigServiciosScreen> createState() => _ConfigServiciosScreenState();
}

class _ConfigServiciosScreenState extends State<ConfigServiciosScreen> {
  ServicioModel servicio =
      ServicioModel(servicio: '', precio: 0, tiempo: '', detalle: '');

  late MyLogicServicio myLogic;

  @override
  void initState() {
    myLogic = MyLogicServicio(servicio);
    myLogic.init();

    super.initState();

    // _askPermissions('/nuevacita');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar servicio"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => agregaServicio(),
        child: const Icon(Icons.plus_one_outlined),
      ),
      body: _formulario(context),
    );
  }

  _formulario(context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          TextField(
            controller: myLogic.textControllerServicio,
            decoration: const InputDecoration(labelText: 'Servicio'),
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: myLogic.textControllerPrecio,
            decoration: const InputDecoration(labelText: 'Precio'),
          ),
          TextField(
            controller: myLogic.textControllerDetalle,
            decoration: const InputDecoration(labelText: 'Detalle'),
          ),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                enabled: false,
                controller: myLogic.textControllerTiempo,
                decoration:
                    const InputDecoration(labelText: 'Tiempo de servicio'),
              ),
              TextButton.icon(
                  onPressed: () => _selectTime(),
                  icon: const Icon(Icons.timer_sharp),
                  label: const Text(''))
            ],
          ),
        ],
      ),
    );
  }

  TimeOfDay _time = const TimeOfDay(hour: 1, minute: 00);

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      helpText: 'INTRODUCE TIEMPO DE SERVICIO',
      initialEntryMode: TimePickerEntryMode.input,
      hourLabelText: 'Horas',
      minuteLabelText: 'Minutos',
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
        myLogic.textControllerTiempo.text = newTime.format(context);
      });
    }
  }

  agregaServicio() {
    final servicio = myLogic.textControllerServicio.text;
    final tiempo = myLogic.textControllerTiempo.text;
    final precio = int.parse(myLogic.textControllerPrecio.text);
    final detalle = myLogic.textControllerDetalle.text;

    CitaListProvider().nuevoServicio(servicio, tiempo, precio, detalle);

    Navigator.pushReplacementNamed(context, 'Servicios');
  }
}
