import 'package:agendacitas/models/cita_model.dart';
import 'package:flutter/material.dart';


/*  id INTEGER PRIMARY KEY,
           nombre TEXT,
           telefono TEXT,
           dia TEXT,
           hora TEXT,
           manospies TEXT,
           icono TEXT,
           servicio TEXT,
           detalle TEXT,
           id_Servicio TEXT */

class MyDetailLogic{
  MyDetailLogic(this.cita);
  final CitaModel cita;


  final textControllerNombre = TextEditingController();
  final textControllerTelefono = TextEditingController();
  final textControllerDia = TextEditingController();
  final textControllerHora= TextEditingController();
  final textControllerManosPies = TextEditingController();
  final textControllerIcono = TextEditingController();
  final textControllerServicio= TextEditingController();
  final textControllerDetalle= TextEditingController();
 
 void save(){
  
 }
  
 void init() {
    if ( cita !=null){
        textControllerNombre.text=   cita.nombre.toString();
        textControllerTelefono.text= cita.telefono.toString();
        textControllerDia.text=      cita.dia.toString();
        textControllerHora.text=     cita.hora.toString();
        textControllerManosPies.text=cita.manospies.toString();
        textControllerServicio.text=cita.servicio.toString();
        textControllerDetalle.text=  cita.detalle.toString();
    }
  }    
}

//TODO: cumplimentar para servicios de uñas
//-------------------------------------------------------
// logic servivios
// 
/*  
class MyDetailLogicServicio{
  MyDetailLogicServicio(this.servicio);
  final ServiceModel servicio;

  final textControllerFecha = TextEditingController();
  final textControllerOdometro= TextEditingController();
  final textControllerTarea = TextEditingController();
  final textControllerTaller= TextEditingController();
  final textControllerCoste= TextEditingController();
  final textControllerNota = TextEditingController();
  final textControllerArchivo= TextEditingController();
 
 void save(){
   
 }
 

 void init() {
    if ( servicio !=null){
        textControllerFecha.text   = servicio.fecha;
        textControllerOdometro.text= servicio.odometro;
        textControllerTarea.text   = servicio.tarea;
        textControllerTaller.text  = servicio.taller;
        textControllerCoste.text  = servicio.coste.toString();
        textControllerNota.text    = servicio.nota;
        textControllerArchivo.text = servicio.archivo;
    }
  }    
}

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