class ClienteModel {
  int? id;
  String? nombre;
  String? telefono;

  ClienteModel({
    this.id,
    this.nombre,
    this.telefono,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
        id: json["id"],
        nombre: json["nombre"],
        telefono: json["telefono"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "telefono": telefono,
      };
}

class CitaModel {
  int? id;
  String? dia;
  String? horaInicio;
  String? horaFinal;
  String? comentario;
  int? idcliente;
  int? idservicio;

  CitaModel({
    this.id,
    this.dia,
    this.horaInicio,
    this.horaFinal,
    this.comentario,
    this.idcliente,
    this.idservicio,
  });

  factory CitaModel.fromJson(Map<String, dynamic> json) => CitaModel(
        id: json["id"],
        dia: json["dia"],
        horaInicio: json["horainicio"],
        horaFinal: json["horafinal"],
        comentario: json["comentario"],
        idcliente: json["id_cliente"],
        idservicio: json["id_servicio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dia": dia,
        "horainicio": horaInicio,
        "horafinal": horaFinal,
        "comentario": comentario,
        "id_cliente": idcliente,
        "id_servicio": idservicio,
      };
}

class ServicioModel {
  int? id;
  String? servicio;
  String? tiempo;
  int? precio;
  String? detalle;

  ServicioModel({
    this.id,
    this.servicio,
    this.tiempo,
    this.precio,
    this.detalle,
  });

  factory ServicioModel.fromJson(Map<String, dynamic> json) => ServicioModel(
        id: json["id"],
        servicio: json["servicio"],
        tiempo: json["tiempo"],
        precio: json["precio"],
        detalle: json["detalle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "servicio": servicio,
        "tiempo": tiempo,
        "precio": precio,
        "detalle": detalle,
      };
}
