/* 

import 'package:agendacitas/screens/contacs_dialog.dart';
import 'package:fast_contacts/fast_contacts.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';



import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:agendacitas/providers/my_detail_logic.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';
import 'package:agendacitas/providers/cita_list_provider.dart';
import 'package:agendacitas/providers/db_provider.dart';
import 'package:agendacitas/models/cita_model.dart';

class CitaScreen extends StatefulWidget {
  var cita;
  CitaScreen({
    Key? key,
     this.cita,
     
  }) : super(key: key);

  @override
  State<CitaScreen> createState() => _CitaScreenState();
}

class _CitaScreenState extends State<CitaScreen> {
  
  int _count = 0;

  String codeArea = '';
  String phoneNumberForm = '';
  String guestName = '';

  //Contacts
  Iterable<Contact> _contacts = [];
  var _actualContact ;



  final List<String> _listaHorarios = [];
  String fechaSeleccionada = '';

  final servicio = {'gel': 2, 'acrilico': 1};

  // opcion lista de texto para elegir tipo de vehiculo
  final _opcionTipo = ['mano', 'pie'];

  String _vistaManoPie = 'MANICURA / PEDICURA';
  String _vistaHorario = 'HORA';

  final opcion = TextEditingController();

  late MyDetailLogic myLogic;

 
  //TODO: pendiente   MyDetailLogicServicio myLogicServicio;

  @override
  void initState() {
    myLogic = MyDetailLogic(cita);
    myLogic.init();

    super.initState();

    // _askPermissions('/nuevacita');
  }

  @override
  Widget build(BuildContext context) {
    
    //TODO: servicioElegido trae {TIPO(gel,acrilico.., y tiempo de servicio, HORA, FECHA)}
     var servicioElegido =  Provider.of<CitaListProvider>(context);

       var servicio = servicioElegido.servicioElegido['TIPO'];
       myLogic.textControllerServicio.text = servicio;
       var hora = servicioElegido.servicioElegido['HORA'];
       myLogic.textControllerHora.text = hora;
       DateFormat dateFormat = DateFormat("yyyy-MM-dd");
       var fecha= dateFormat.format(servicioElegido.servicioElegido['FECHA']);
       myLogic.textControllerDia.text = fecha;
       DateFormat dateFormatHora = DateFormat("HH:mm");
       var tiempo =dateFormatHora.format(servicioElegido.servicioElegido['TIEMPO']) ;
       myLogic.textControllerTiempo.text = tiempo;



    return Scaffold(
      appBar: AppBar(
        title: const Text('NUEVA CITA'),
        actions: [
          TextButton(
            child: const Text(
              'IR A CALENDARIO',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pushNamed(context, '/'),
          )
        ],
      ),
      /* floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.plus_one_rounded),
          onPressed: () => verTodasCitas(context, citasprovider),
        ), */
      body: SingleChildScrollView(child: _form(servicioElegido)),

      //! pruebas eventuales de visionado de citas
      // Container(child: verTodasCitas(context, citasprovider),)
    );
  }

  Widget _form(servicioElegido) {
    return Container(
        margin: const EdgeInsets.all(30.0),
        child: Column(
          children: [
             Card(child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(children: [
                    Stack( 
                      children:[
                        TextField(
                          controller: myLogic.textControllerNombre,
                          decoration: const InputDecoration(labelText: 'Clienta'),
                         ),
                         Row( 
                           crossAxisAlignment: CrossAxisAlignment.end,
                           mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                                        
                           TextButton( 
                             onPressed: ()=>{}, 
                             child: const Icon(Icons.favorite_border_outlined ),
                             ),
                            TextButton(
                             onPressed: ()=>_showContactList(context), 
                             child: const Icon(Icons.contact_phone_outlined) ,                
                            ),
                          ],)
                         ] 
                        ),
                            TextField(
                                  //!--------------------------------telefono
                                  controller: myLogic.textControllerTelefono,
                                  decoration: const InputDecoration(labelText: 'Teléfono'),
                                ),

               ],),
             ),),
           
            //!---------------------------------dia
            
            TextField(
              enabled : false,
              onChanged: (value) => setState(() {
                print(value);
              }), //fechaSeleccionada = value,

              controller: myLogic.textControllerDia,
              decoration: InputDecoration(labelText: 'Día'),
            ),
            //!---------------------------------hora

            TextField(
              enabled : false,
              controller: myLogic.textControllerHora,
              decoration: InputDecoration(labelText: 'Hora'),
            ),
           TextField(
              controller: myLogic.textControllerServicio,
              decoration: InputDecoration(labelText: 'Servicio'),
            ),
               TextField(
              controller: myLogic.textControllerTiempo,
              decoration: InputDecoration(labelText: 'Duración'),
            ),
            TextField(
              controller: myLogic.textControllerPrecio,
              decoration: InputDecoration(labelText: 'Precio'),
            ),
            TextField(
              controller: myLogic.textControllerDetalle,
              decoration: InputDecoration(labelText: 'Detalle'),
            ),
            SizedBox(
              height: 50.0,
            ),
            ElevatedButton(
                child: (myLogic.cita.nombre != '')
                    ? Text('Editar')
                    : Text('Añadir'),
                onPressed: () {
                  // Navigator.pushNamed(context, '/');

                  (myLogic.cita.nombre != '')
                      ? editar(
                          context,
                          myLogic.cita.id,
                          myLogic.textControllerNombre.text,
                          myLogic.textControllerTelefono.text,
                          myLogic.textControllerDia.text,
                          myLogic.textControllerHora.text,
                          myLogic.textControllerManosPies.text,
                          myLogic.textControllerServicio.text,
                          myLogic.textControllerPrecio.text,
                          myLogic.textControllerDetalle.text,
                        )
                      : nuevo(
                          context,
                          myLogic.textControllerNombre.text,
                          myLogic.textControllerTelefono.text,
                          myLogic.textControllerDia.text,
                          myLogic.textControllerHora.text,
                          myLogic.textControllerManosPies.text,
                          myLogic.textControllerServicio.text,
                           myLogic.textControllerTiempo.text,
                          myLogic.textControllerPrecio.text,
                          myLogic.textControllerDetalle.text,
                        );
                }),
          ],
        ));
  }

  nuevo(BuildContext context, String nombre, String telefono, String dia,
      String hora, String manospies, String servicio, String tiempo, String precio, String detalle) async {
    final citaListProvider =
        Provider.of<CitaListProvider>(context, listen: false);
    citaListProvider.nuevaCita(
        nombre, telefono, dia, hora, manospies, servicio, tiempo, precio, detalle);

    final snackBar = SnackBar(content: Text('CITA CREADA CORRECTAMENTE'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    
    Navigator.pushNamed(context, '/');
  }

  editar(
      BuildContext context,
      int? id,
      String nombre,
      String telefono,
      String dia,
      String hora,
      String manospies,
      String servicio,
      String precio,
      String detalle) {}

//? SELECCIONAR HORA
  funcionHorarios(context) {
    var time = TimeOfDay.now();
    Intl.defaultLocale = 'es';

    showMaterialTimePicker(
      context: context,
      selectedTime: time,
      onChanged: (value) => setState(() => myLogic.textControllerHora.text =
          (value.hour.toString().padLeft(2, '0') +
              ':' +
              value.minute.toString().padLeft(2, '0'))),
    );
  }

  _showContactList(BuildContext context) async {

    List<Contact> favoriteElements = [];
    final InputDecoration searchDecoration = const InputDecoration();

    await refreshContacts();
    
    if (_contacts != null)
    {
      showDialog(
        context: context,
        builder: (_) =>
            SelectionDialogContacts(
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
     

  }



  //Check contacts permission
   Future<void> _askPermissions(context, String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        Navigator.of(context).pushNamed(routeName);
      }
    } else {
      _handleInvalidPermissions(context,permissionStatus);
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

  void _handleInvalidPermissions(context,PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
   



// inicializa cita
final cita = CitaModel(
  nombre: "",
  telefono: '',
  dia: DateFormat("yyyy-MM-dd").format(DateTime.now()),
  hora: "10:00",
  servicio: "acrilico",
  precio: '',
  detalle: 'otros comentarios',
);




 */