import 'package:agendacitas/screens/citaScreen.dart';
import 'package:flutter/material.dart';
import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:agendacitas/screens/horasScreen.dart';

class ServiciosScreen extends StatefulWidget {
  final String fecha;

  ServiciosScreen({Key? key, required this.fecha}) : super(key: key);

  @override
  State<ServiciosScreen> createState() => _ServiciosScreenState();
}

class _ServiciosScreenState extends State<ServiciosScreen> {
  //TODO: hacer provider de lista Servicios y su grabacione en BD
  List<String> listaServicios = [];

  DateTime horasServicio  = DateTime.now();
   DateTime horaTotal = DateTime.now() ;

  var servicioSeleccionado = 'Elige servicio';

  @override
  Widget build(BuildContext context) {

    var servicioElegido =  Provider.of<CitaListProvider>(context);
    
    Map<String, DateTime> servicios = Provider.of<CitaListProvider>(context, listen: false).servicios;
    /*  final servicios = {
              'GEL'      : DateTime(2022, 1, 1, 1, 00, 00),  //servicio 1 gel 1h
              'ACRILICO' : DateTime(2022, 1, 1, 2, 00, 00),  //servicio 2 agrilico 2h
            }; */

    listaServicios = servicios.keys.map((e) => e).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text('Servicios- ${widget.fecha}'),
        ),
        body: Column(
          children: [
            Text(servicioSeleccionado),
            SizedBox(height: 100),
            Expanded(
              child: ListView.builder(
                itemCount: listaServicios.length,
                itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                        //! SERVICIOS DEBE SER CONFIGURADO POR CLIENTE
                         switch (listaServicios[index]) {
                           case 'GEL': 
                                 horasServicio = DateTime.parse(widget.fecha);
                                 DateTime timpoServicio =  DateTime.parse('2000-01-01 01:00:00Z');
                                 horaTotal = horasServicio.add(Duration(hours: timpoServicio.hour, minutes: timpoServicio.minute));
                             break;
                          case 'ACRILICO': 
                                 horasServicio = DateTime.parse(widget.fecha);
                                 DateTime timpoServicio =  DateTime.parse('2000-01-01 02:00:00Z');
                                 horaTotal = horasServicio.add(Duration(hours: timpoServicio.hour, minutes: timpoServicio.minute));
                                 
                                 
                             break;

                           
                         }
                   
                           servicioElegido.servicioElegido = {
                                listaServicios[index] : horaTotal
                                
                           };
                    
                           servicioSeleccionado = servicioElegido.servicioElegido.toString();
                            
                           
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HorasScreen(
                            fecha: widget.fecha, servicio: index.toString()),
                      ),
                    );

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(child: Text('${listaServicios[index]}')),
                  ));
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(
                  context,
                  'nuevacita'
                  
                )));
  }
}
