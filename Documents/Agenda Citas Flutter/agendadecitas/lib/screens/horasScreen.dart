import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:agendacitas/providers/db_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HorasScreen extends StatefulWidget {
  final String fecha, servicio;
  HorasScreen({Key? key, required this.fecha, required this.servicio})
      : super(key: key);

  @override
  State<HorasScreen> createState() => _HorasScreenState();
}

class _HorasScreenState extends State<HorasScreen> {
  List<String> listaServicios = [];
  final List<String> _listaHorarios = [];
  String fechaSeleccionada = '';
  var servicioElegido;
  int _horaDeServicio = 1;

  horarios( String fecha) async {
   
    //  final fechaAux = DateTime.parse('$fecha '); //! no lo utilizo

    //      print(fechaAux);
    //var sixtyDaysFromNow = now.add(const Duration(days: 60));
    //TODO: hacerlo dinamico para futuras configuraciones de cliente
    final List<String> _opcionHora = [
      '09:30',
      '10:00',
      '10:30',
      '11:00',
      '11:30',
      '12:00',
      '12:30',
      '13:00',
      '13:30'
    ];

    //  Map<String, DateTime> servicios = Provider.of<CitaListProvider>(context, listen: false).servicios;
    /*  final servicios = {
                'GEL'      : DateTime(2022, 1, 1, 1, 00, 00),  //servicio 1 gel 1h
                'ACRILICO' : DateTime(2022, 1, 1, 2, 00, 00),  //servicio 2 agrilico 2h
              }; */
    //     print('Servicios $servicios');

    List<CitaModel> citas = await DBProvider.db.getCitasHoraOrdenadaPorFecha(
        fecha); //? ver como extraer citas desde el provider
    print('Fecha seleccionada -> $fecha');
    print('citas -> $citas');
    //? comprueba si no hay citas, para introducir horario completo
    if (citas.isEmpty) {
      setState(() {
        _listaHorarios.addAll(_opcionHora);
      });
    } else {
      //? mapeo de citas para extraer citas.hora
      final auxCitasHora = citas.map((e) => e.hora);

      //? mapeo _opcionHora (horario completo) y compruebo si existe hora de cita, si existe la guardo,
      //? en listafinal   => listafinal= [{10:00},{10:30}]   (lista iterable)
      print('axuCitasHora ${auxCitasHora}');

      final listafinal = _opcionHora
          .map((e) => {(!auxCitasHora.contains(e)) ? e : 'ND'});
      //! los elementos de listafinal los añado a _listaHorarios con e.first  [{10:00},{10:30}]
      listafinal.forEach((e) => {
            setState(() {
              _listaHorarios.add(e.first);
            })
          });

      print('lista horarios $_listaHorarios');
    }
  }

 
  @override
  void initState() {
    
    
     horarios( widget.fecha);

    //horarios(context, widget.fecha);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var servicioElegido =  Provider.of<CitaListProvider>(context);
 // horarios( servicioElegido.servicioElegido.values.first.toString());
    DateFormat dateFormat = DateFormat("HH:mm");  //? 1h gel, 2h acrilico
    final horaServicio = dateFormat.format(servicioElegido.servicioElegido.values.first); 
    print(horaServicio);

    String myHora = horaServicio.substring(0, 2);
      _horaDeServicio = int.parse(myHora);
  
    String myMin = horaServicio.substring(2, 4);
    print(int.parse(myHora));
     
    List<String> _listaDisponible = [];

 
      print('lista de horarios $_listaHorarios')  ;
      for (var i = 0; i < _listaHorarios.length; i++) {
          
            if( _listaHorarios[i] == 'ND'){
                      
                    //!  tener en cuenta horas de servicio, 1 HORA -1, 2 HORAS -2, ...
                    
                      setState(() {
                        _listaDisponible.add('ND');
                        var x = 0;
                          for (var y = _horaDeServicio; y > 0; y--) {
                              x++;
                            _listaDisponible[(i-x <0)? i : i-x] = 'NDispon';
                            
                          }
                      });
        
            }else{
                    setState(() {
                        _listaDisponible.add(_listaHorarios[i]);
                    });
            } 
      }

  


    return Scaffold(
      appBar: AppBar(title: Text(servicioElegido.servicioElegido.toString(), style: TextStyle(fontSize: 12),)/* Text('${widget.fecha} serv: ${widget.servicio}') */),
      body: ListView.builder(
          itemCount: _listaDisponible.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 120.0,
                  height: 50.0,
                  child: GestureDetector(
                    onTap: ()=> Navigator.pushNamed(context,'nuevacita' ),
                    child: Card(child: Text('${_listaDisponible[index]}')))),
            );
          }),
    );
  }
}
