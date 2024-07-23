import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode((str)));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel{
  String nombre; 
  int edad; 
  String email;
  String calle;
  String numExterior;
  int numInterior;
  String colonia;
  String municipio;
  String estado;
  String telefono;
  String fechaNac;
  String sexo;

  UserModel({
    required this.nombre, 
    required this.edad, 
    required this.email, 
    required this.calle,
    required this.numExterior,
    required this.numInterior,
    required this.colonia,
    required this.municipio,
    required this.estado,
    required this.telefono,
    required this.fechaNac,
    required this.sexo,
    });

  factory UserModel.fromJson(Map<String, dynamic>json)=> UserModel
  (nombre: json['nombre'], 
  edad: json['edad'], 
  email: json['email'],
  calle: json['calle'],
  numExterior: json['numExterior'],
  numInterior: json['numInterior'],
  colonia: json['colonia'],
  municipio: json['municipio'],
  estado: json['estado'],
  telefono: json['telefono'],
  fechaNac: json['fechaNac'],
  sexo: json['sexo'],
  );

  Map<String, dynamic> toJson()=>{
    'nombre': nombre,
    'edad' : edad,
    'email' : email,
    'calle': calle,
    'numEterior': numExterior,
    'numInterior': numInterior,
    'colonia': colonia,
    'municipio': municipio,
    'estado': estado,
    'telefono': telefono,
    'fechaNac':fechaNac,
    'sexo': sexo,
  };
}