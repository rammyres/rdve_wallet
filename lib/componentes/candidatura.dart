import 'package:flutter/material.dart';
import 'package:rdve_wallet/modelos/candidato.dart';
import 'package:rdve_wallet/modelos/eleitor.dart';

class Candidatura extends StatefulWidget {
  final Eleitor eleitor;
  Candidatura(this.eleitor);

  @override
  _CandidaturaState createState() => _CandidaturaState(eleitor);
}

class _CandidaturaState extends State<Candidatura> {
  Eleitor eleitor;
  Candidato candidato;

  _CandidaturaState(this.eleitor);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registrar candidatura",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
      ),
    );
  }
}
