import 'package:flutter/material.dart';

class MyTransicionRuta {
  Route createRoute( paginadestino) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => paginadestino,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.linear;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  
}