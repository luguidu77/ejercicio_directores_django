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
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
         CREATE TABLE Cita(
           id INTEGER PRIMARY KEY,
           nombre TEXT,
           telefono TEXT,
           dia TEXT,
           hora TEXT,
           manospies TEXT,
           icono TEXT,
           servicio TEXT,
           detalle TEXT,
           id_Servicio TEXT
         )         
        ''');
      await db.execute('''
         CREATE TABLE Servicio(
           id INTEGER PRIMARY KEY,
           servicio TEXT,
           manospies TEXT,
           icono DOUBLE,
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

  Future<int> nuevaCita(CitaModel nuevaCita) async {
    // Verifica la base de datos
    final db = await database;
    final res = await db!.insert('Cita', nuevaCita.toJson());

    // RES Es el ID del último registro guardado
    return res;
  }

  Future<List<CitaModel>> getTodasLasCitas() async {
    final db = await database;
    final res = await db!.query('Cita');
    return res.isNotEmpty ? res.map((s) => CitaModel.fromJson(s)).toList() : [];
  }

  Future<List<CitaModel>> getCitasHoraOrdenadaPorFecha(String fecha) async {
    final db = await database;
    final res = await db!.rawQuery("select * from Cita where dia='$fecha'");

    return res.isNotEmpty ? res.map((s) => CitaModel.fromJson(s)).toList() : [];
  }

  Future<List<CitaModel>> getCitasHoraOrdenada() async {
    final db = await database;
    final res = await db!.query(
      'Cita',
      orderBy: 'hora',
    );

    return res.isNotEmpty ? res.map((s) => CitaModel.fromJson(s)).toList() : [];
  }
}
