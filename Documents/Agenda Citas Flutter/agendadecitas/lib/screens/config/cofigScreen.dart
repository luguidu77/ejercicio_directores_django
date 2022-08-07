import 'package:agendacitas/models/cita_model.dart';
import 'package:agendacitas/providers/my_detail_logic.dart';
import 'package:flutter/material.dart';

class ConfigScreen extends StatefulWidget {
  ConfigScreen({Key? key}) : super(key: key);

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  ServicioModel servicio =
      ServicioModel(servicio: '', precio: 0, tiempo: '', detalle: '');

  late MyLogicServicio myLogic;

  @override
  void initState() {
    myLogic = MyLogicServicio(servicio);
    myLogic.init();

    super.initState();

    // _askPermissions('/nuevacita');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.plus_one_outlined),
      ),
      body: _formulario(context),
    );
  }

  _formulario(context) {
    List iconos = const [
      Icon(Icons.design_services_outlined),
      Icon(Icons.cleaning_services_sharp)
    ];
    List listaConfiguraciones = ['Tema', 'Servicios'];

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: listaConfiguraciones.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: iconos[index],
                  title: GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, '${listaConfiguraciones[index]}'),
                      child: Text('${listaConfiguraciones[index]}')),
                );
              }),
        )
      ],
    );
  }
}
