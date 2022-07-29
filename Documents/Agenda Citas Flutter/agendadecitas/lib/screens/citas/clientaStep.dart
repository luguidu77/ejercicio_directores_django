import 'package:agendacitas/models/cita_model.dart';
import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:agendacitas/providers/db_provider.dart';
import 'package:agendacitas/providers/my_detail_logic.dart';
import 'package:agendacitas/screens/contacs_dialog.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ClientaStep extends StatefulWidget {
  final clienteParametro;
  ClientaStep({Key? key, this.clienteParametro}) : super(key: key);

  @override
  State<ClientaStep> createState() => _ClientaStepState();
}

class _ClientaStepState extends State<ClientaStep> {
  final _formKey = GlobalKey<FormState>();
  Iterable<Contact> _contacts = [];
  var _actualContact;

  ClienteModel cliente = ClienteModel(nombre: '', telefono: '');

  late MyLogicCliente myLogic;

  @override
  void initState() {
    myLogic = MyLogicCliente(widget.clienteParametro);
    myLogic.init();
    print(widget.clienteParametro);

    super.initState();

    // _askPermissions('/nuevacita');
  }

  @override
  Widget build(BuildContext context) {
    var clientaElegida = Provider.of<CitaListProvider>(context);

    var clienta = clientaElegida.getClientaElegida;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Creación de Cita'),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.arrow_right_outlined),
          onPressed: () async => {
                if (_formKey.currentState!.validate())
                  {
                    setState(() {
                      seleccionaCliente(context, clientaElegida);
                    }),
                    Navigator.pushNamed(context, 'servicioStep')
                  }
              }),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(clienta.toString()),
                selectClienta(context),
                const SizedBox(height: 50),
                selectTelefono(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget selectClienta(BuildContext context) {
    return Container(
      width: 300,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.blue)),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: TextFormField(
            validator: (value) => _validacion(value),
            controller: myLogic.textControllerNombre,
            decoration: const InputDecoration(
                labelText: 'Nombre Clienta',
                border: UnderlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, 'clientesScreen'),
              child: const Icon(Icons.favorite_border_outlined),
            ),
            TextButton(
              onPressed: () => _showContactList(context),
              child: const Icon(Icons.contact_phone_outlined),
            ),
          ],
        )
      ]),
    );
  }

  Widget selectTelefono() {
    return Container(
      width: 300,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.blue)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextFormField(
          validator: (value) => _validacion(value),
          keyboardType: TextInputType.number,
          controller: myLogic.textControllerTelefono,
          decoration: const InputDecoration(
              labelText: 'Teléfono clienta',
              border: UnderlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    );
  }

  _validacion(value) {
    if (value.isEmpty) {
      return 'Este campo no puede quedar vacío';
    }
  }

  _showContactList(BuildContext context) async {
    List<Contact> favoriteElements = [];
    final InputDecoration searchDecoration = const InputDecoration();

    await refreshContacts();

    if (_contacts != null) {
      showDialog(
        context: context,
        builder: (_) => SelectionDialogContacts(
          _contacts.toList(),
          favoriteElements,
          showCountryOnly: false,
          emptySearchBuilder: null,
          searchDecoration: searchDecoration,
        ),
      ).then((e) {
        if (e != null) {
          setState(() {
            _actualContact = e;
          });
          print('CONTACTO ELEGIDO ${_actualContact.phones}');
          myLogic.textControllerNombre.text = _actualContact.displayName;
          myLogic.textControllerTelefono.text = _actualContact.phones.first;
        }
      });
    }
  }

// Getting list of contacts from AGENDA
  refreshContacts() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      Iterable<Contact> contacts = await FastContacts.allContacts;
      print('PERMISO CONCEDIDO');
      setState(() {
        print(contacts);
        _contacts = contacts;
      });
    } else {
      _handleInvalidPermissions(context, permissionStatus);
    }
  }

  List<ClienteModel> clientes = [];

  int idCliente = 0;
//!CONTEXTO CLIENTA SELECCIONADA CLIENTASTEP
  seleccionaCliente(context, clienta) async {
    // quitar  espacios del nuemero de telefono porque no lo encuentra
    myLogic.textControllerTelefono.text = myLogic.textControllerTelefono.text
        .replaceAll(" ", "")
        .replaceAll("+", "");

    clientes = await CitaListProvider()
        .cargarClientePorTelefono(myLogic.textControllerTelefono.text);

    print('cliente ----------$clientes ${myLogic.textControllerTelefono.text}');

    if (clientes.isEmpty) {
      //todo: quitar el + y espacios del nuemero de telefono porque no lo encuentra
      ClienteModel nuevoCliente = await CitaListProvider().nuevoCliente(
          myLogic.textControllerNombre.text,
          myLogic.textControllerTelefono.text);
      idCliente = nuevoCliente.id!;
    } else {
      idCliente = clientes[0].id!;
    }

    print('ID cliente ----------$idCliente');
    clienta.setClientaElegida = {
      'ID': idCliente.toString(),
      'NOMBRE': myLogic.textControllerNombre.text,
      'TELEFONO': myLogic.textControllerTelefono.text,
    };
  }
}

//Check contacts permission
Future<void> _askPermissions(context, String routeName) async {
  PermissionStatus permissionStatus = await _getContactPermission();
  if (permissionStatus == PermissionStatus.granted) {
    if (routeName != null) {
      Navigator.of(context).pushNamed(routeName);
    }
  } else {
    _handleInvalidPermissions(context, permissionStatus);
  }
}

Future<PermissionStatus> _getContactPermission() async {
  PermissionStatus permission = await Permission.contacts.status;
  if (permission != PermissionStatus.granted &&
      permission != PermissionStatus.permanentlyDenied) {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    return permissionStatus;
  } else {
    return permission;
  }
}

void _handleInvalidPermissions(context, PermissionStatus permissionStatus) {
  if (permissionStatus == PermissionStatus.denied) {
    final snackBar = SnackBar(content: Text('Access to contact data denied'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
    final snackBar =
        SnackBar(content: Text('Contact data not available on device'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
