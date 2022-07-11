// ignore_for_file: unnecessary_new

import 'dart:async';

import 'package:agendacitas/providers/db_provider.dart';
import 'package:flutter/material.dart';

class CitaListProvider extends ChangeNotifier {
  bool _cargando = false;
  int _tarjetaPage = 0;

  List<CitaModel> citas = [];
  String tipoSeleccionado = 'MANO';

  Future<CitaModel> nuevaCita(String nombre, String telefono, String dia,
      String hora, String manospies, String servicio, String detalle) async {
    final nuevaCita = new CitaModel(
      nombre: nombre.toUpperCase(),
      telefono: telefono,
      dia: dia,
      hora: hora,
      manospies: manospies,
      servicio: servicio.toUpperCase(),
      detalle: detalle.toUpperCase(),
    );

    final id = await DBProvider.db.nuevaCita(nuevaCita);

    //asinar el ID de la base de datos al modelo
    nuevaCita.id = id;

    citas.add(nuevaCita);
    notifyListeners();

    return nuevaCita;
  }

  /*   editarCar(id, String tipo, String marca, String modelo, String matricula, String fmatriculacion, String bastidor) async {
       final editaCar = new CitaModel(
         id: id,
         nombre:nombre.toUpperCase(),
         matricula: matricula.toUpperCase(),
         marca:marca.toUpperCase(),
         modelo: modelo.toUpperCase(),
         fmatriculacion:fmatriculacion,
         bastidor: bastidor         .toUpperCase()
         );

        editaCar.id = id;
        await DBProvider.db.updateCar(editaCar);
        this.cars = [...cars];
     
    }
     */

  cargarCitas() async {
    final citas = await DBProvider.db.getTodasLasCitas();
    this.citas = [...citas];
    notifyListeners();
    return citas;
  }

  cargarCitasPorFecha(String fecha) async {
    final citas = await DBProvider.db.getCitasHoraOrdenadaPorFecha(fecha);
    this.citas = [...citas];

    // this.tipoSeleccionado = fecha;
    notifyListeners();

    return citas;
  }
  /*
    borrarTodos() async {
      await DBProvider.db.deleteAllCars();
      this.cars = [];
      notifyListeners();
    }

    borrarCarPorId(int id) async {
      await DBProvider.db.deleteCar(id);
      
    }
 */

  //TODO: tengo que hacerlo dinamico y guardar en DB
  final servicios = {
    'GEL': DateTime(2022, 1, 1, 1, 00, 00), //servicio 1 gel 1h
    'ACRILICO': DateTime(2022, 1, 1, 2, 00, 00), //servicio 2 agrilico 2h
  };

   Map<String, DateTime> _servicioElegido = {};

   Map<String, DateTime> get servicioElegido => _servicioElegido;

   set servicioElegido(Map<String, DateTime> nuevoServicio){
    _servicioElegido = nuevoServicio;
    notifyListeners();

   } 

}
