
import 'package:crudusrs/bd/constantes.dart';
import 'package:crudusrs/bd/mongo_provider.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter/material.dart';

class MongoCrud extends MongoProvider{
  Db? db;
  List resultadosBusqueda=[];

  @override
  Future<Db> open(String nombreCollecion)async{
    try {
      db = await Db.create(CONECCION);
      db!.collection(nombreCollecion);
      debugPrint('Base de datos conectada');
      return db!;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
  @override 
  Future<void> close(){
    try {
      db! .close();
      debugPrint('base de datos cerrada con exito');
    } catch (e) {
      debugPrint(e.toString());
    }
    return Future.value();
  }

  @override
  Future<void>insertarItem(
    String nombreCollecion, Map<String, dynamic> documento) async{
      try {
        await open(nombreCollecion);
        await db!.collection(nombreCollecion).insert(documento);
        debugPrint('documento agregado con exito');
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    @override
  Future<void>eliminarItem(ObjectId id, String nombreCollecion) async{
      try {
        await open(nombreCollecion);
        await db!.collection(nombreCollecion).remove(where.id(id));
        debugPrint('documento eliminado con exito');
      } catch (e) {
        debugPrint(e.toString());
      }
    }

   @override
  Future<void>actualizarItem(ObjectId id, String nombreCollecion, documento) async{
      try {
        await open(nombreCollecion);
        await db!.collection(nombreCollecion).update(where.id(id), documento);
        debugPrint('actualizado con exito');
      } catch (e) {
        debugPrint(e.toString());
      }
    }

  @override
  Future<List> getLista(String nombreCollecion) async{
    try {
      await open(nombreCollecion);
     var listaUsuarios = await db!.collection(nombreCollecion).find().toList();
     debugPrint('docuemnto encontrado');
     return listaUsuarios;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
  
  void onSearchTextChanged(String searchtext, 
  List<dynamic> collectionList){
    resultadosBusqueda.clear();
    if (searchtext.isEmpty) {
      resultadosBusqueda=[];
    }

    resultadosBusqueda = collectionList
    .where((element) =>element['nombre']
    .toString()
    .toLowerCase()
    .contains(searchtext.toLowerCase()))
    .toList();
  }
}
