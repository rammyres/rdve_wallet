import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rdve_wallet/componentes/novoUsuario.dart';

class AvisoCandidatoMesario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ops",
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Text(
              "Candidatos a cargos eletivos não podem atuar como operadores de urna",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          RaisedButton(
              color: Colors.blue,
              child: Text(
                "OK",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => new NovoUsuario(),
                  ),
                );
              })
        ],
      ),
    );
  }
}
