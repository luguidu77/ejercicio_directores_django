import 'package:agendacitas/models/cita_model.dart';
import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:agendacitas/providers/my_detail_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CitaStep extends StatefulWidget {
  CitaStep({Key? key}) : super(key: key);

  @override
  State<CitaStep> createState() => _CitaStepState();
}

class _CitaStepState extends State<CitaStep> {
  CitaModel cita = CitaModel();
  final _formKey = GlobalKey<FormState>();
  TextStyle estilotextoErrorValidacion = const TextStyle(color: Colors.red);
  String textoErrorValidacionFecha = '';
  String textoErrorValidacionHora = '';

  /*  _getServicio() {
    return servicio = CitaListProvider().getServicioElegido;
  } */

  late MyLogicCita myLogic;

  String textoDia = '';
  String textoFechaHora = '';

  @override
  void initState() {
    myLogic = MyLogicCita(cita);

    myLogic.init();
    /*  servicio = _getServicio();
    print(servicio); */
    super.initState();

    // _askPermissions('/nuevacita');
  }

  @override
  Widget build(BuildContext context) {
    var _micontexto = Provider.of<CitaListProvider>(context);
    var cita = _micontexto.getCitaElegida;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creación de Cita'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_right_outlined),
        onPressed: () async => {
          if (_formKey.currentState!.validate())
            {
              setState(() {
                seleccionaCita(context, _micontexto);
              }),
              Navigator.pushNamed(context, 'confirmarStep')
            }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(cita.toString()),
                selectDia(context),
                const SizedBox(height: 50),
                selectHora(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectDia(context) {
    return Column(
      children: [
        Container(
          width: 300,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: Colors.blue)),
          child: Stack(alignment: Alignment.centerRight, children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black87),
                    labelText: 'Día de la cita',
                    border: UnderlineInputBorder(borderSide: BorderSide.none)),
                validator: (value) => _validacionFecha(value),
                enabled: false,
                controller: myLogic.textControllerDia,
                // decoration: const InputDecoration(labelText: 'Día de la cita'),
              ),
            ),
            TextButton.icon(
                onPressed: () => funcionDia(context),
                icon: const Icon(Icons.date_range),
                label: const Text(''))
          ]),
        ),
        //? hago esta validación porque no se ve TEXTO VALIDATOR si está inabilitado a la escritura
        Text(
          textoErrorValidacionFecha,
          style: estilotextoErrorValidacion,
        )
      ],
    );
  }

  Widget selectHora(context) {
    return Column(
      children: [
        Container(
          width: 300,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(color: Colors.blue)),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  validator: (value) => _validacionHora(value),
                  enabled: false,
                  controller: myLogic.textControllerHora,
                  decoration: const InputDecoration(
                      labelText: 'Hora de la cita',
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              TextButton.icon(
                  onPressed: () => funcionHorarios(context),
                  icon: const Icon(Icons.timer_sharp),
                  label: const Text(''))
            ],
          ),
        ),
        //? hago esta validación porque no se ve TEXTO VALIDATOR si está inabilitado a la escritura
        Text(
          textoErrorValidacionHora,
          style: estilotextoErrorValidacion,
        )
      ],
    );
  }

  funcionDia(context) {
    var firsDdate = DateTime.now();
    var lastDate = DateTime.now().add(const Duration(hours: 720));
    Intl.defaultLocale = 'es';

    showMaterialDatePicker(
        context: context,
        firstDate: firsDdate,
        lastDate: lastDate,
        selectedDate: firsDdate,
        onChanged: (value) {
          setState(() {
            myLogic.textControllerDia.text =
                (value.day.toString()) + '-' + value.month.toString();
          });
          //todo: pasar por formatar fecha
          textoDia = value.year.toString() +
              '-' +
              value.month.toString().padLeft(2, '0') +
              '-' +
              value.day.toString().padLeft(2, '0');
        });
  }

  funcionHorarios(context) {
    var time = TimeOfDay.now();
    Intl.defaultLocale = 'es';

    showMaterialTimePicker(
      context: context,
      selectedTime: time,
      onChanged: (value) {
        setState(() {
          myLogic.textControllerHora.text =
              (value.hour.toString().padLeft(2, '0') +
                  ':' +
                  value.minute.toString().padLeft(2, '0'));

          textoFechaHora = (textoDia.toString() +
              ' ' +
              value.hour.toString().padLeft(2, '0') +
              ':' +
              value.minute.toString().padLeft(2, '0') +
              ':' +
              '00Z');
        });
      },
    );
  }

  _validacionFecha(value) {
    if (value.isEmpty) {
      textoErrorValidacionFecha = 'Este campo no puede quedar vacío';
      setState(() {});
      return 'Este campo no puede quedar vacío';
    } else {
      textoErrorValidacionFecha = '';
      setState(() {});
    }
  }

  _validacionHora(value) {
    if (value.isEmpty) {
      textoErrorValidacionHora = 'Este campo no puede quedar vacío';
      setState(() {});
      return 'Este campo no puede quedar vacío';
    } else {
      textoErrorValidacionHora = '';
      setState(() {});
    }
  }

//TODO: traer horas y minutos de trabajo para sumarlas
  void seleccionaCita(BuildContext context, micontexto) async {
    DateTime fechaInicio = DateTime.parse(textoFechaHora);
    var servicio = micontexto.getServicioElegido;
    String tiempoServicio = servicio['TIEMPO'];
    int tiempoServicioHoras =
        int.parse(tiempoServicio[0] + '' + tiempoServicio[1]);

    int tiempoServicioMinutos =
        int.parse(tiempoServicio[3] + '' + tiempoServicio[4]);

    DateTime fechaFinal = fechaInicio.add(
        Duration(hours: tiempoServicioHoras, minutes: tiempoServicioMinutos));

    print('fecha1  $fechaInicio ');

    micontexto.setCitaElegida = {
      'FECHA': textoDia,
      'HORAINICIO': fechaInicio,
      'HORAFINAL': fechaFinal
    };
  }
}
