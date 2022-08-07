import 'package:flutter/material.dart';

class BarraProgreso {
  progreso(double progreso, Color color) {
    return SizedBox(
      width: 290,
      child: Column(
        children: [
          const SizedBox(
            child: Text(
              'Creando una cita',
              style: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: LinearProgressIndicator(
              color: color,
              minHeight: 10,
              value: progreso,
            ),
          ),
        ],
      ),
    );
  }
}
