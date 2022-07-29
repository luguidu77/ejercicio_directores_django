import 'package:agendacitas/models/cita_model.dart';
import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:agendacitas/screens/citas/clientaStep.dart';
import 'package:flutter/material.dart';

class ClientesScreen extends StatefulWidget {
  ClientesScreen({Key? key}) : super(key: key);

  @override
  State<ClientesScreen> createState() => _ClientesScreenState();
}

class _ClientesScreenState extends State<ClientesScreen> {
  @override
  void initState() {
    datosClientes();
    super.initState();
  }

  List<ClienteModel> listaClientes = [];
  List<ClienteModel> listaAux = [];
  List<ClienteModel> aux = [];

  datosClientes() async {
    listaAux = await CitaListProvider().cargarClientes();
    listaClientes = listaAux;
    aux = listaAux;
    setState(() {});
    print(listaClientes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clientes'),
      ),
      body: Column(
        children: [
          _textoBusqueda(),
          _listaClientes(),
        ],
      ),
    );
  }

  _textoBusqueda() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Busqueda de clienta',
                  helperText: 'mínimo 3 letras'),
              onChanged: (String value) {
                if (value.length > 2) {
                  for (var item in listaClientes) {
                    !item.nombre
                            .toString()
                            .contains(value.toUpperCase().toString())
                        ? !listaAux.contains(item)
                            ? listaAux.add(item)
                            : listaAux.remove(item)
                        : null;

                    aux = listaAux;
                    setState(() {});
                  }
                } else {
                  datosClientes();
                  aux = listaClientes;
                  setState(() {});
                }
                print(listaClientes);
                //  listaClientes = aux;
              },
              controller: null,
              // decoration: InputDecoration(labelText: 'Clienta'),
            ),
          ],
        ),
      ),
    );
  }

  _listaClientes() {
    return Expanded(
      flex: 8,
      child: ListView.builder(
          itemCount: aux.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ClientaStep(
                          clienteParametro: ClienteModel(
                              nombre: listaClientes[index].nombre,
                              telefono: listaClientes[index].telefono))),
                );
              }, //todo: navegar a pagina de la clienta, cargar sus citas y poder crear una nueva
              child: ListTile(
                leading: const Icon(Icons.face_sharp),
                title: Text(listaClientes[index].nombre.toString()),
                subtitle: Text(listaClientes[index].telefono.toString()),
                trailing: const Icon(Icons.phone_android),
              ),
            );
          }),
    );
  }
}
