import 'dart:io';

import 'package:agendacitas/models/cita_model.dart';
import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:agendacitas/providers/my_detail_logic.dart';
import 'package:agendacitas/screens/citas/confirmarStep.dart';
import 'package:agendacitas/utils/transicion_ruta.dart';
import 'package:agendacitas/widgets/barra_progreso.dart';
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
  String alertaHora = '';
  /*  _getServicio() {
    return servicio = CitaListProvider().getServicioElegido;
  } */

  late MyLogicCita myLogic;

  String textoDia = '';
  String textoFechaHora = '';
  bool _disponible = false;

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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_right_outlined),
        onPressed: () async => {
          if (_formKey.currentState!.validate())
            {
              _disponible = await seleccionaCita(context, _micontexto),
              setState(() {}),
              if (_disponible)
                {
                  Navigator.of(context)
                      .push(MyTransicionRuta().createRoute(ConfirmarStep()))
                }
              else
                {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Icon(
                              Icons.warning,
                              color: Colors.red,
                            ),
                            content: Text('Tienes una cita de $alertaHora'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Modificar hora'))
                            ],
                          ))
                }
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
                // Text(cita.toString()),
                BarraProgreso().progreso(
                  0.9,
                  Colors.green,
                ),
                const SizedBox(height: 50),
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
        title: 'Día de la cita',
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
      title: 'Hora de la cita',
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
  seleccionaCita(BuildContext context, micontexto) async {
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

    _disponible = await _compruebaDisponibilidad(
        tiempoServicioHoras, tiempoServicioMinutos);
    print('disponible: $_disponible');
    setState(() {});
    return _disponible;
  }

  _compruebaDisponibilidad(tiempoServicioHoras, tiempoServicioMinutos) async {
    bool _disp = true;
    List<Map<String, dynamic>> _citas =
        await CitaListProvider().cargarCitasPorFecha(textoDia);

    //todo: comprobar disponibilidad PARA COMPROBANDO TODAS LAS CITAS PREVIAS
    if (_citas.isNotEmpty) {
      List _auxInicio = _citas.map((e) => (e['horaInicio'])).toList();
      List _auxFinal = _citas.map((e) => (e['horaFinal'])).toList();
      print(_auxInicio);
      print(_auxFinal);

      for (var i = 0; i < _citas.length && _disp != false; i++) {
        DateTime _ip = DateTime.parse(_auxInicio[i].toString());
        DateTime _fp = DateTime.parse(_auxFinal[i].toString());

        alertaHora =
            '${_ip.hour}:${_ip.minute.toString().padLeft(2, '0')} a ${_fp.hour}:${_fp.minute.toString().padLeft(2, '0')}';
        print('hora inicio cita cogida $_ip');
        print('hora final cita cogida $_fp');

        DateTime _in = DateTime.parse(textoFechaHora);
        DateTime _fn = _in.add(Duration(
            hours: tiempoServicioHoras, minutes: tiempoServicioMinutos));

        print('hora INICIO nueva cita $_in');
        print('hora FINAL nueva cita $_fn');

        bool valIpIn = _ip.isBefore(_in);
        bool valFpIn = _fp.isBefore(_in) || _fp == _in;
        bool valIpFn = _ip.isAfter(_fn) || _ip.isAtSameMomentAs(_fn);

        /* LOGICA:   p(CONGIDA)   n(NUEVA)

                 ?   Ip < In
                 ?         SI ES TRUE :   Fp <= In  -> FALSE (CITA ENCONTRADA)
                 ?         SI ES FALSE:   Ip >= Fn  -> FALSE (CITA ENCONTRADA)
         */

        if (valIpIn) {
          valFpIn ? _disp = true : _disp = false;
        } else {
          valIpFn ? _disp = true : _disp = false;
        }
      }
    }

    return _disp;
  }
}
