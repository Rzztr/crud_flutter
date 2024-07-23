import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:crudusrs/bd/mongo_crud.dart';
import 'package:crudusrs/view/user_model.dart';
import 'package:crudusrs/view/cuadroTexto.dart';
import 'package:crudusrs/view/cuadro_busqueda.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController nombreTextEditingController = TextEditingController();
  TextEditingController edadTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController calleTextEditingController = TextEditingController();
  TextEditingController numExteriorTextEditingController = TextEditingController();
  TextEditingController numInteriorTextEditingController = TextEditingController();
  TextEditingController coloniaTextEditingController = TextEditingController();
  TextEditingController municipioTextEditingController = TextEditingController();
  TextEditingController telefonoTextEditingController = TextEditingController();
  TextEditingController fechaNacTextEditingController = TextEditingController();
  TextEditingController sexoTextEditingController = TextEditingController();
  TextEditingController estadoTextEditingController = TextEditingController();

  MongoCrud mongoCrud = MongoCrud();
  List <dynamic>?  listaUsuarios;

  @override
  void initState(){
    fetchData();
  super.initState();
  }

  Future<void> fetchData() async {
    listaUsuarios = await mongoCrud.getLista('usuarios');
    jsonEncode(listaUsuarios);
    debugPrint(listaUsuarios.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operaciones CRUD'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        await mongoCrud.insertarItem('usuarios', UserModel(
          nombre: nombreTextEditingController.text.toString(), 
          edad: int.parse(edadTextEditingController.text), 
          email: emailTextEditingController.text.toString(), 
          calle: calleTextEditingController.text.toString(), 
          numExterior: numExteriorTextEditingController.text.toString(),
          numInterior: int.parse(sexoTextEditingController.text),
          colonia: coloniaTextEditingController.text.toString(),
          municipio: municipioTextEditingController.text.toString(),
          estado: estadoTextEditingController.text.toString(),
          telefono:telefonoTextEditingController.text.toString(),
          fechaNac: fechaNacTextEditingController.text.toString(),
          sexo: sexoTextEditingController.text.toString(),
          
          ).toJson());
          listaUsuarios = await mongoCrud.getLista('usuarios');
          setState(() { });
          nombreTextEditingController.clear();
          edadTextEditingController.clear();
          emailTextEditingController.clear();
          calleTextEditingController.clear();
          numExteriorTextEditingController.clear();
          numInteriorTextEditingController.clear();
          coloniaTextEditingController.clear();
          municipioTextEditingController.clear();
          estadoTextEditingController.clear();
          telefonoTextEditingController.clear();
          fechaNacTextEditingController.clear();
          sexoTextEditingController.clear();
      },
      child: const Icon(Icons.add)
      ),
      body: SingleChildScrollView(
        child: Column(children: [
           const SizedBox(height: 20,),
           CuadroPersonalizado(campoTexto: nombreTextEditingController, hintText: 'nombre'),
          const  SizedBox(height: 20,),
           CuadroPersonalizado(campoTexto: edadTextEditingController, hintText: 'edad'),
           const SizedBox(height: 20,),
           CuadroPersonalizado(campoTexto: emailTextEditingController, hintText: 'email'),
           const SizedBox(height: 20,),
           CuadroPersonalizado(campoTexto: calleTextEditingController, hintText: 'Calle'),
           const SizedBox(height: 20,),
           CuadroPersonalizado(campoTexto: numExteriorTextEditingController, hintText: 'numero exterior'),
           const SizedBox(height: 20,),
           CuadroPersonalizado(campoTexto: numInteriorTextEditingController, hintText: 'numero interior'),
           const SizedBox(height: 20,),
           CuadroPersonalizado(campoTexto: coloniaTextEditingController, hintText: 'Colonia'),
           const SizedBox(height: 20,),
           CuadroPersonalizado(campoTexto: municipioTextEditingController, hintText: 'Municipio'),
           const SizedBox(height: 20,),
           CuadroPersonalizado(campoTexto: estadoTextEditingController, hintText: 'Estado'),
           const SizedBox(height: 20,),
           CuadroPersonalizado(campoTexto: telefonoTextEditingController, hintText: 'telefono'),
           const SizedBox(height: 20,),
           CuadroPersonalizado(campoTexto: fechaNacTextEditingController, hintText: 'fecha de nacimiento'),
           const SizedBox(height: 20,),
           CuadroPersonalizado(campoTexto: sexoTextEditingController, hintText: 'Sexo'),

           const SizedBox(height: 20
           ),

           CuadroBusqueda(
            onChanged:(p0){
              setState(() {
                mongoCrud.onSearchTextChanged(p0, listaUsuarios ?? <dynamic>[]);
              });
            },
           hintText: 'Busqueda'),
           mongoCrud.resultadosBusqueda.isNotEmpty
              ? ListView.builder(
                  controller: ScrollController(),
                  shrinkWrap: true,
                  itemCount: mongoCrud.resultadosBusqueda.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(mongoCrud.resultadosBusqueda[index]['nombre']),
                        subtitle: RichText(
                          text: TextSpan(
                              text: mongoCrud.resultadosBusqueda[index]['email'],
                              style: const TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(
                                    text: ' - ',
                                    style: TextStyle(color: Colors.black)),
                                TextSpan(
                                    text: mongoCrud.resultadosBusqueda[index]
                                            ['edad']
                                        .toString(),
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ]),
                        ),
                        trailing: Wrap(
                          children: [
                            IconButton(
                                onPressed: () async {
                                  await mongoCrud.actualizarItem(
                                      mongoCrud.resultadosBusqueda[index]['_id'],
                                      'usuarios',
                                      UserModel(
                                              nombre:nombreTextEditingController.text.toString(),
                                              edad: int.parse(edadTextEditingController.text),
                                              email: emailTextEditingController.text.toString(),
                                              calle: calleTextEditingController.text.toString(),
                                              numExterior: numExteriorTextEditingController.text.toString(),
                                              numInterior: int.parse(sexoTextEditingController.text),
                                              colonia: coloniaTextEditingController.text.toString(),
                                              municipio: municipioTextEditingController.text.toString(),
                                              estado: estadoTextEditingController.text.toString(),
                                              telefono:telefonoTextEditingController.text.toString(),
                                              fechaNac: fechaNacTextEditingController.text.toString(),
                                              sexo: sexoTextEditingController.text.toString(),
                                                  ).toJson());
                                  listaUsuarios =
                                      await mongoCrud.getLista('usuarios');
                                  setState(() {});
                                },
                                icon: const Icon(Icons.update)),
                            IconButton(
                                onPressed: () async {
                                  await mongoCrud.eliminarItem(
                                      mongoCrud.resultadosBusqueda[index]['_id'],
                                      'usuarios');
                                  listaUsuarios =
                                      await mongoCrud.getLista('usuarios');
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  })
              //* User List
              : listaUsuarios != null
                  ? ListView.builder(
                      controller: ScrollController(),
                      shrinkWrap: true,
                      itemCount: listaUsuarios!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: ListTile(
                              leading: const Icon(Icons.person),
                              title: Text(listaUsuarios![index]['nombre']),
                              subtitle: RichText(
                                text: TextSpan(
                                    text: listaUsuarios![index]['email'],
                                    style: const TextStyle(color: Colors.black),
                                    children: [
                                      const TextSpan(
                                          text: ' - ',
                                          style:
                                              TextStyle(color: Colors.black)),
                                      TextSpan(
                                          text: listaUsuarios![index]['edad']
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.black)),
                                    ]),
                              ),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        await mongoCrud.eliminarItem(
                                            listaUsuarios![index]['_id'],
                                            'usuarios');
                                        listaUsuarios =
                                            await mongoCrud.getLista('usuarios');
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () async {
                                        await mongoCrud.actualizarItem(
                                            listaUsuarios![index]['_id'],
                                            'usuarios',
                                            UserModel(
                                              nombre:nombreTextEditingController.text.toString(),
                                              edad: int.parse(edadTextEditingController.text),
                                              email: emailTextEditingController.text.toString(),
                                              calle: calleTextEditingController.text.toString(),
                                              numExterior: numExteriorTextEditingController.text.toString(),
                                              numInterior: int.parse(sexoTextEditingController.text),
                                              colonia: coloniaTextEditingController.text.toString(),
                                              municipio: municipioTextEditingController.text.toString(),
                                              estado: estadoTextEditingController.text.toString(),
                                              telefono:telefonoTextEditingController.text.toString(),
                                              fechaNac: fechaNacTextEditingController.text.toString(),
                                              sexo: sexoTextEditingController.text.toString(),
                                                  ).toJson());
                                        listaUsuarios =
                                            await mongoCrud.getLista('usuarios');
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.update)),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : const CircularProgressIndicator()
        ],),
      ),
    );
  }
}