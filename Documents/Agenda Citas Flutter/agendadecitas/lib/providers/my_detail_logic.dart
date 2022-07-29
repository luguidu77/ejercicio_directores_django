import 'package:agendacitas/models/cita_model.dart';
import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:flutter/material.dart';

class MyLogicCita {
  MyLogicCita(this.cita);
  final CitaModel cita;

  var citaContext = CitaListProvider().getCitaElegida;

  final textControllerDia = TextEditingController();
  final textControllerHora = TextEditingController();

  void save() {}

  void init() {
    if (cita.hashCode.isNaN) {
      textControllerDia.text = cita.dia.toString();
      textControllerHora.text = cita.horaInicio.toString();
      textControllerHora.text = cita.horaFinal.toString();
    }
  }
}

class MyLogicCliente {
  MyLogicCliente(this.cliente);
  final ClienteModel cliente;

  final textControllerNombre = TextEditingController();
  final textControllerTelefono = TextEditingController();

  void save() {}

  void init() {
    if (cliente != null) {
      textControllerNombre.text = cliente.nombre.toString();
      textControllerTelefono.text = cliente.telefono.toString();
    }
  }
}

class MyLogicServicio {
  MyLogicServicio(this.servicio);
  final ServicioModel servicio;

  final textControllerPrecio = TextEditingController();
  final textControllerServicio = TextEditingController();
  final textControllerTiempo = TextEditingController();
  final textControllerDetalle = TextEditingController();

  void save() {}

  void init() {
    if (servicio != null) {
      textControllerPrecio.text = servicio.precio.toString();
      textControllerServicio.text = servicio.servicio.toString();
      textControllerTiempo.text = servicio.tiempo.toString();
      textControllerDetalle.text = servicio.detalle.toString();
    }
  }
}

/*

class MyDetailLogicRecordatorio{
  MyDetailLogicRecordatorio(this.recordatorio);
  final RecordatorioModel recordatorio;

  final textControllerFecha = TextEditingController();
  final textControllerOdometro= TextEditingController();
  final textControllerTarea = TextEditingController();
  
 
 void save(){
   
 }
 

 void init() {
    if ( recordatorio !=null){
        textControllerFecha.text   = recordatorio.fecha;
        textControllerOdometro.text= recordatorio.odometro;
        textControllerTarea.text   = recordatorio.tarea;
        
    }
  }    
} */