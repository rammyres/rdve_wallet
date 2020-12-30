import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rdve_wallet/componentes/novoUsuario.dart';

class AvisoMesarioCandidato extends StatelessWidget {
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
          Text(
            "Mesário não podem ser candidatos nas eleiçõeos em que estejam trabalhando",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 35,
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
