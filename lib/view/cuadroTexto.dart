import 'package:flutter/material.dart';

class CuadroPersonalizado extends StatelessWidget {
  const CuadroPersonalizado({super.key, required this.campoTexto,required this.hintText});
  final TextEditingController campoTexto;
  final String hintText;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        controller: campoTexto, 
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          hintText: hintText.toString()
        ),
      ),
    );
  }
}