


class CitaModel{
  int? id;
  String? nombre;
  String? telefono;
  String? dia;
  String? hora;
  String? manospies;
  String? icono;
  String? servicio;
  String? detalle;


  CitaModel({
    this.id,
    this.nombre,
    this.telefono,
    this.dia,
    this.hora,
    this.manospies,
    this.icono,
    this.servicio,
    this.detalle 
  }){
    switch (manospies) {
      
      case 'pies':
        icono='icono pies';
        break;
        
      default:
        icono='icono mano';
    }
  }


  factory CitaModel.fromJson(Map<String, dynamic> json) => CitaModel(
        id: json["id"],
        nombre: json["nombre"],
        telefono: json["telefono"],
        dia: json["dia"],
        hora: json["hora"],
        manospies: json["manospies"],
        icono: json["icono"],
        servicio: json["servicio"],
        detalle: json["detalle"],
    );


  Map<String, dynamic> toJson()=>{
    "id": id,
    "nombre": nombre,
    "telefono": telefono,
    "dia": dia,
    "hora": hora,
    "manospies": manospies,
    "icono": icono,
    "servicio": servicio,
    "detalle": detalle



  };

}