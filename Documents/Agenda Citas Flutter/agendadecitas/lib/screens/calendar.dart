import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:agendacitas/providers/db_provider.dart';

import 'package:agendacitas/screens/serviciosScreen.dart';
import 'package:agendacitas/utils.dart';

import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<Event> listaEventos = [];
  Map<DateTime, List<Event>> todosLosEventos = {};

  List<Map<DateTime, List<Event>>> listaAux = [];

//? TRAIGO LOS CITAS DESDE LA BASE DE DATOS , PARA REPRESENTARLAS EN PANTALLA EVENTOS DEL CALENDARIO
  dbcitas() async {
    final citas = await DBProvider.db.getCitasHoraOrdenada();

    setState(() {
      final listaCitas = citas.map((e) => e.toJson()).toList();

               print('LISTA CITAS: $listaCitas');

      List existe =[];
      listaCitas.forEach((element) {

        //? compruebo si existe la misma fecha del evento, si NO EXISTE añado a listaAux {DateTime: Event()}
         if(!(existe.contains(element['dia'])  )){

            existe.add(element['dia']); //? en este array añado las fechas para poder comprobar si ya existe
             
            listaAux.add(
              {
                (DateTime.parse(element['dia']))   : [Event(element['dia'] + ' ' + element['nombre'] +' ' +   element['servicio'] +' ' +   element['hora'] +' h')]
              }
            );
         }else{
               //? si EXISTE la fecha, añado el Event() en VALUES de listaAux a traves del indice que coincide con la misma FECHA (key) del array,  
   
               listaAux[existe.indexOf(element['dia'])].values.first.add( Event(element['dia'] + ' ' + element['nombre'] +' ' +   element['servicio'] +' ' +   element['hora'] +' h') );
         }
      });

      print('TODOS LOS EVENTOS: $listaAux');
      //? por cada fecha varios eventos . {DateTime(2022, 7, 18): listaEventos,}
      listaAux.forEach((element) => {todosLosEventos.addAll(element)});
    });
   
  }

  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    dbcitas();

    _selectedDay = _focusedDay;

    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // final fecha =  fechas;
    /* Map<DateTime, List<Event>> */
    final _kEventSource = todosLosEventos;

    LinkedHashMap<DateTime, List<Event>> eventos =
        LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_kEventSource);

    return eventos[day] ?? [];

    // Implementation example
    //return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            locale: 'es_ES',
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Agrega cita'),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ServiciosScreen(
                    fecha: _focusedDay.year.toString().padLeft(2, '0') +
                        '-' +
                        _focusedDay.month.toString().padLeft(2, '0') +
                        '-' +
                        _focusedDay.day.toString().padLeft(2, '0'))

                /*CitaScreen(
                        // ! TENGO QUE MANDAR UNA CITA QUE NO SEA NULA A LA PAGINA DE CITASCREEN ,
                        // ! EN CITASCREEN EVALUO SI LLEGA UN NOMBRE DE CLIENTA VACIO (EDITAR O AGREGAR)
                        cita: CitaModel(
                          nombre: '',
                          telefono: '',
                          dia: '',
                          hora: '',
                          manospies: '',
                          servicio: '',
                          detalle: ''
                         ),*/

                ),
          )
        }, // Navigator.pushNamed(context, 'nuevacita' ),
      ),
    );
  }
}
