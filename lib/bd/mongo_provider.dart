import 'package:mongo_dart/mongo_dart.dart';

abstract class MongoProvider<T>{
  Future<Db> open(String nombreCollecion);
  Future<void> close();
  Future<void> insertarItem(String nombreCollecion, Map<String, dynamic> documento);
  Future<void> eliminarItem(ObjectId id, String nombreCollecion);
  Future<void> actualizarItem(ObjectId id, String nombreCollecion, T documento);
  Future<List<T?>> getLista(String nombreCollecion); 
}