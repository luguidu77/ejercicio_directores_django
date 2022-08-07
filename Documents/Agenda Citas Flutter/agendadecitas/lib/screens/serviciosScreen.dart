import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:flutter/material.dart';

class ServiciosScreen extends StatefulWidget {
  ServiciosScreen({Key? key}) : super(key: key);

  @override
  State<ServiciosScreen> createState() => _ServiciosScreenState();
}

class _ServiciosScreenState extends State<ServiciosScreen> {
  List listaAux = [];
  List listaservicios = [];
  List listNombreServicios = [];
  List listIdServicios = [];

  cargarDatosServicios() async {
    listaAux = await CitaListProvider().cargarServicios();
    listaservicios = listaAux;

    for (var item in listaservicios) {
      listNombreServicios.add(item.servicio.toString());
      listIdServicios.add(item.id);
    }

    setState(() {});
  }

  @override
  void initState() {
    cargarDatosServicios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'configServicios'),
        child: const Icon(Icons.plus_one),
      ),
      body: _servicios(context),
    );
  }

  _servicios(context) {
    print(listIdServicios);
    print(listNombreServicios);

    return Column(
      children: [
        const Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Crea o elimina servicios'),
              ),
            )),
        Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: listNombreServicios.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: Text(listIdServicios[index].toString()),
                        title: Text(listNombreServicios[index]),
                        trailing: TextButton.icon(
                          onPressed: () async {
                            await _mensajeAlerta(context, index);
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text(''),
                        ),
                      ),
                    );
                  }),
            )),
      ],
    );
  }

  _mensajeAlerta(BuildContext context, int index) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: const Icon(
                Icons.warning,
                color: Colors.red,
              ),
              content: Text(
                  '¿ Quieres eliminar la cita de ${listNombreServicios[index]}?'),
              actions: [
                TextButton(
                    onPressed: () async {
                      await CitaListProvider()
                          .elimarServicio(listIdServicios[index]);
                      listNombreServicios.remove(listNombreServicios[index]);
                      listIdServicios.remove(listIdServicios[index]);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: const Text(
                      ' Sí, eliminar ',
                      style: TextStyle(
                          fontSize: 18,
                          backgroundColor: Colors.red,
                          color: Colors.white),
                    )),
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: const Text(
                      ' No ',
                      style: TextStyle(fontSize: 18),
                    )),
              ],
            ));
  }
}
