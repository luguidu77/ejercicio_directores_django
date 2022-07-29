import 'package:agendacitas/models/cita_model.dart';
import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:agendacitas/providers/my_detail_logic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicioStep extends StatefulWidget {
  ServicioStep({Key? key}) : super(key: key);

  @override
  State<ServicioStep> createState() => _ServicioStepState();
}

class _ServicioStepState extends State<ServicioStep> {
  final _formKey = GlobalKey<FormState>();
  ServicioModel servicio =
      ServicioModel(id: 0, servicio: '', tiempo: '', precio: 0, detalle: '');
  int indexServicio = 0;
  List<ServicioModel> listaservicios = [];
  List<ServicioModel> listaAux = [];
  List<String> listNombreServicios = [];
  String dropdownValue = '';

  late MyLogicServicio myLogic;

  cargarDatosServicios() async {
    listaAux = await CitaListProvider().cargarServicios();
    listaservicios = listaAux;

    for (var item in listaservicios) {
      listNombreServicios.add(item.servicio.toString());
      dropdownValue = listNombreServicios[0];
    }

    setState(() {});
  }

  @override
  void initState() {
    myLogic = MyLogicServicio(servicio);
    myLogic.init();

    cargarDatosServicios();

    super.initState();

    // _askPermissions('/nuevacita');
  }

  @override
  Widget build(BuildContext context) {
    var servicioElegido = Provider.of<CitaListProvider>(context);
    var servicio = servicioElegido.getServicioElegido;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creación de Cita'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_right_outlined),
        onPressed: () async => {
          if (_formKey.currentState!.validate())
            {Navigator.pushNamed(context, 'citaStep')}
          //await seleccionaServicio(context),
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(servicio.toString()),

              //? LISTA DE SERVICIOS
              listaServicios(context),
              const SizedBox(height: 50),
              precioServicio(servicio),
            ],
          ),
        ),
      ),
    );
  }

  Container listaServicios(context) {
    return Container(
      width: 300,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.blue)),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
                border: UnderlineInputBorder(borderSide: BorderSide.none)),
            //opcion color para cambio tema: iconEnabledColor: Colors.amber,
            hint: const Text('ELIGE UN SERVICIO'),

            validator: (value) =>
                value == null ? 'Seleciona un servicio' : null,
            items: listNombreServicios
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                int index = listNombreServicios.indexOf(dropdownValue);
                seleccionaServicio(context, index);
                indexServicio = index;
              });
            },
          )),
    );
  }

  Container precioServicio(servicio) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.blue)),
      child: SizedBox(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextField(
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
              onChanged: (e) {
                servicio['PRECIO'] = e;
                setState(() {});
              },
              controller: myLogic.textControllerPrecio,
              decoration:
                  const InputDecoration(labelText: 'Precio', suffixText: '€')),
        ),
      ),
    );
  }

  _validacion(value) {
    if (value.isEmpty) {
      return 'Este campo no puede quedar vacío';
    }
  }

  seleccionaServicio(context, index) {
    var servicioElegido = Provider.of<CitaListProvider>(context, listen: false);

    servicioElegido.setServicioElegido = {
      'ID': index,
      'SERVICIO': listaservicios[index].servicio.toString(),
      'TIEMPO': listaservicios[index].tiempo.toString(),
      'PRECIO': listaservicios[index].precio.toString(),
      'DETALLE': listaservicios[index].detalle.toString(),
    };
    myLogic.textControllerPrecio.text = listaservicios[index].precio.toString();
    setState(() {});
  }
}
