// ignore_for_file: unnecessary_new

import 'dart:async';

import 'package:agendacitas/providers/db_provider.dart';
import 'package:flutter/material.dart';

class CitaListProvider extends ChangeNotifier {
  bool _cargando = false;
  int _tarjetaPage = 0;

  List<ClienteModel> clientes = [];
  List<CitaModel> citas = [];
  List<ServicioModel> servicios = [];
  String tipoSeleccionado = 'MANO';

  Future<ClienteModel> nuevoCliente(
    String nombre,
    String telefono,
  ) async {
    final nuevoCliente = new ClienteModel(
      nombre: nombre.toUpperCase(),
      telefono: telefono,
    );

    final id = await DBProvider.db.nuevoCliente(nuevoCliente);

    //asinar el ID de la base de datos al modelo
    nuevoCliente.id = id;

    clientes.add(nuevoCliente);
    notifyListeners();

    return nuevoCliente;
  }

  Future<CitaModel> nuevaCita(String dia, String horaInicio, String horaFinal,
      String comentario, int idCliente, int idServicio) async {
    final nuevaCita = new CitaModel(
        dia: dia,
        horaInicio: horaInicio,
        horaFinal: horaFinal,
        comentario: comentario,
        idcliente: idCliente,
        idservicio: idServicio);

    final id = await DBProvider.db.nuevaCita(nuevaCita);

    //asinar el ID de la base de datos al modelo
    nuevaCita.id = id;

    citas.add(nuevaCita);
    notifyListeners();

    return nuevaCita;
  }

  Future<ServicioModel> nuevoServicio(
      String servicio, String tiempo, int precio, String detalle) async {
    final nuevoServicio = new ServicioModel(
      servicio: servicio,
      tiempo: tiempo,
      precio: precio,
      detalle: detalle,
    );

    final id = await DBProvider.db.nuevoServicio(nuevoServicio);

    //asinar el ID de la base de datos al modelo
    nuevoServicio.id = id;

    servicios.add(nuevoServicio);
    notifyListeners();

    return nuevoServicio;
  }

  cargarCitas() async {
    final citas = await DBProvider.db.getTodasLasCitas();
    this.citas = [...citas];
    notifyListeners();
    return citas;
  }

  List<Map<String,dynamic>> data = [];

  // List<ClienteModel> cientes = [];
  ClienteModel _cliente = ClienteModel();
  ServicioModel _servicio = ServicioModel();

  cargarCitasPorFecha(String fecha) async {
    List<CitaModel> citas =
        await DBProvider.db.getCitasHoraOrdenadaPorFecha(fecha);

    for (var item in citas) {
      _cliente = await DBProvider.db.getCientePorId(item.idcliente!);
      _servicio = await DBProvider.db.getServicioPorId(item.idservicio! + 1);

      data.add({
        'horaInicio': item.horaInicio,
        'horaFinal': item.horaFinal,
        'nombre': _cliente.nombre,
        'servicio': _servicio.servicio,
        'precio': _servicio.precio,
        'detalle': _servicio.detalle
      });
    }

    //  this.data = [...data];
    //print(data.toString());

    notifyListeners();

    return data;
  }

  cargarServicios() async {
    final servicios = await DBProvider.db.getTodoslosServicios();
    this.servicios = [...servicios];
    notifyListeners();
    return servicios;
  }

  cargarClientes() async {
    final clientes = await DBProvider.db.getTodosLosClientes();
    this.clientes = [...clientes];
    notifyListeners();
    return clientes;
  }

/*   Future<List<ClienteModel>> cargarClientePorCita(int idCita) async {
    final clientes = await DBProvider.db.getCientePorId(idCita);
    this.clientes = [...clientes];
    // this.tipoSeleccionado = fecha;
    notifyListeners();

    return clientes;
  } */

  cargarClientePorTelefono(String telefono) async {
    //todo: quitar el + y espacios del nuemero de telefono porque no lo encuentra
    final clientes = await DBProvider.db.getCientePorTelefono(telefono);
    this.clientes = [...clientes];
    // this.tipoSeleccionado = fecha;
    notifyListeners();

    return clientes;
  }

  elimarCita(int id) async {
    await DBProvider.db.eliminarCita(id);
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

//! CONTEXTO clientaElegida
  Map<String, dynamic> _clientaElegida = {
    'ID': 0,
    'NOMBRE': '',
    'TELEFONO': '',
  };

  Map<String, dynamic> get getClientaElegida => _clientaElegida;

  set setClientaElegida(Map<String, dynamic> nuevoCliente) {
    _clientaElegida = nuevoCliente;
    notifyListeners();
  }

//! CONTEXTO servicioElegido
  Map<String, dynamic> _servicioElegido = {
    'ID': 0,
    'SERVICIO': '',
    'TIEMPO': '',
    'PRECIO': '',
    'DETALLE': '',
  };

  Map<String, dynamic> get getServicioElegido => _servicioElegido;

  set setServicioElegido(Map<String, dynamic> nuevoServicio) {
    _servicioElegido = nuevoServicio;
    notifyListeners();
  }

  //! CONTEXTO citaElegida
  Map<String, dynamic> _citaElegida = {
    'FECHA': '',
    'HORAINICIO': '',
    'HORAFINAL': '',
  };

  Map<String, dynamic> get getCitaElegida => _citaElegida;

  set setCitaElegida(Map<String, dynamic> nuevaCita) {
    _citaElegida = nuevaCita;
    notifyListeners();
  }
}
