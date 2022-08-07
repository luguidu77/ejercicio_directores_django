import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:agendacitas/models/cita_model.dart';
export 'package:agendacitas/models/cita_model.dart';

// inicializar SQFLITE
//https://stackoverflow.com/questions/67049107/the-non-nullable-variable-database-must-be-initialized

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path + '/' + 'agendacitas.db');
    WidgetsFlutterBinding.ensureInitialized();

    //crear base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onConfigure: (db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }, onCreate: (Database db, int version) async {
      await db.execute('''
         CREATE TABLE Cita(
           id INTEGER PRIMARY KEY,
           dia TEXT,
           horainicio TEXT,
           horafinal TEXT,
           comentario TEXT,
           id_cliente,
           id_servicio
          )         
        ''');
      await db.execute('''
         CREATE TABLE Cliente(
           id INTEGER PRIMARY KEY,
           nombre TEXT,
           telefono TEXT 
          )         
        ''');
      await db.execute('''
         CREATE TABLE Servicio(
           id INTEGER PRIMARY KEY,
           servicio TEXT,
           tiempo TEXT,
           precio INTEGER,
           detalle TEXT
         )         
        ''');
      await db.execute('''
          CREATE TABLE Recordatorios(
            id INTEGER PRIMARY KEY,
            fecha TEXT,
            odometro TEXT,
            tarea TEXT,
            como TEXT,
            id_Car INTEGER
          )         
          ''');
      await db.execute('''
          CREATE TABLE Notificaciones(
            id INTEGER PRIMARY KEY,
            leading TEXT,
            title TEXT,
            subtitle TEXT
          )         
          ''');
    });
  }

  Future<int> nuevoCliente(ClienteModel nuevoCliente) async {
    // Verifica la base de datos
    final db = await database;
    final res = await db!.insert('Cliente', nuevoCliente.toJson());

    // RES Es el ID del último registro guardado
    return res;
  }

  Future<int> nuevaCita(CitaModel nuevaCita) async {
    // Verifica la base de datos
    final db = await database;
    final res = await db!.insert('Cita', nuevaCita.toJson());

    // RES Es el ID del último registro guardado
    return res;
  }

  Future<int> nuevoServicio(ServicioModel nuevoServicio) async {
    // Verifica la base de datos
    final db = await database;
    final res = await db!.insert('Servicio', nuevoServicio.toJson());

    // RES Es el ID del último registro guardado
    return res;
  }

  Future<List<CitaModel>> getTodasLasCitas() async {
    final db = await database;
    final res = await db!.query('Cita');
    return res.isNotEmpty ? res.map((s) => CitaModel.fromJson(s)).toList() : [];
  }

  Future<List<ClienteModel>> getTodosLosClientes() async {
    final db = await database;
    final res = await db!.query('Cliente');
    return res.isNotEmpty
        ? res.map((s) => ClienteModel.fromJson(s)).toList()
        : [];
  }

  Future<List<ServicioModel>> getTodoslosServicios() async {
    final db = await database;
    final res = await db!.query('Servicio');
    return res.isNotEmpty
        ? res.map((s) => ServicioModel.fromJson(s)).toList()
        : [];
  }

  Future<List<CitaModel>> getCitasHoraOrdenadaPorFecha(String fecha) async {
    final db = await database;
    final res = await db!.rawQuery("select * from Cita where dia='$fecha'");

    return res.isNotEmpty ? res.map((s) => CitaModel.fromJson(s)).toList() : [];
  }

  Future<ClienteModel> getCientePorId(int id) async {
    final db = await database;
    final res = await db!.query(
      "Cliente",
      where: 'id = $id',
    );
    return ClienteModel.fromJson(res.first);
    /* return res.isNotEmpty
        ? res.map((s) => ClienteModel.fromJson(s)).toList()
        : []; */
  }

  Future<ServicioModel> getServicioPorId(int id) async {
    final db = await database;
    final res = await db!.query(
      "Servicio",
      where: 'id = $id',
    );
    return ServicioModel.fromJson(res.first);
    /* return res.isNotEmpty
        ? res.map((s) => ClienteModel.fromJson(s)).toList()
        : []; */
  }

  Future<List<ClienteModel>> getCientePorTelefono(String telefono) async {
    final db = await database;
    final res = await db!.query(
      "Cliente",
      where: 'telefono = $telefono',
    );

    return res.isNotEmpty
        ? res.map((s) => ClienteModel.fromJson(s)).toList()
        : [];
  }
/*   Future<List<CitaModel>> getCitasHoraOrdenada() async {
    final db = await database;
    final res = await db!.query(
      'Cita',
      orderBy: 'hora',
    );

    return res.isNotEmpty ? res.map((s) => CitaModel.fromJson(s)).toList() : [];
  } */

  eliminarCita(int id) async {
    final db = await database;

    final res = await db!.delete(
      'Cita',
      where: 'id = $id',
    );
    return res;
  }

  eliminarServicio(int id) async {
    final db = await database;

    final res = await db!.delete(
      'Servicio',
      where: 'id = $id',
    );
    return res;
  }
}
