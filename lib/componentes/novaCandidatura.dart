import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rdve_wallet/componentes/avisoMesarioCandidato.dart';
import 'package:rdve_wallet/componentes/candidatura.dart';
import 'package:rdve_wallet/componentes/dialogoAlerta.dart';
import 'package:rdve_wallet/componentes/modalApelido.dart';
import 'package:rdve_wallet/componentes/modalNumero.dart';
import 'package:rdve_wallet/componentes/novoUsuario.dart';
import 'package:rdve_wallet/modelos/candidato.dart';
import 'package:rdve_wallet/modelos/eleitor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NovaCandidatura extends StatefulWidget {
  final Eleitor eleitor;

  NovaCandidatura(this.eleitor);

  @override
  _NovaCandidaturaState createState() => _NovaCandidaturaState();
}

class _NovaCandidaturaState extends State<NovaCandidatura> {
  String _numero;
  String _apelido;
  Candidato _candidato;

  carregarDados(Eleitor eleitor) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool("ehMesario") ?? false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => new AvisoMesarioCandidato(),
        ),
      );
    }

    if (prefs.getBool("ehCandidato") ?? false) {
      setState(() {
        this._candidato = Candidato(
          prefs.getString('id'),
          prefs.getString('numero'),
          prefs.getString('apelido'),
          prefs.getString('endereco_cand'),
          prefs.getString('chavePrivada_cand'),
          prefs.getString('requisicao'),
        );
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => new Candidatura(_candidato),
        ),
      );
    }
  }

  Future<void> salvarDados() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('ehCandidato', true);
    prefs.setString('numero', this._candidato.numero);
    prefs.setString('apelido', this._candidato.apelido);
    prefs.setString('endereco_cand', this._candidato.endereco);
    prefs.setString('chavePrivada_cand', this._candidato.chavePrivada.toHex());
    prefs.setString('requisicao', json.encode(this._candidato.requisicao));
  }

  @override
  void initState() {
    carregarDados(widget.eleitor);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        carregarDados(widget.eleitor);
      },
    );

    super.initState();
  }

  void _obterNumero(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return ModalNumero(_editarNumero);
      },
    );
  }

  void _obterApelido(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return ModalApelido(_editarApelido);
      },
    );
  }

  void _editarApelido(String apelido) {
    setState(() {
      this._apelido = apelido;
    });
  }

  void _editarNumero(String numero) {
    setState(() {
      this._numero = numero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => new NovoUsuario(),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Registrar candidatura",
            style: TextStyle(
              fontSize: 28,
            ),
          ),
        ),
        body: FractionallySizedBox(
          heightFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Vamos cadastrar sua candidatura",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Text("Apelido do candidato"),
              FlatButton(
                onPressed: () {
                  _obterApelido(context);
                },
                child: Text(
                  _apelido != null
                      ? _apelido
                      : "Toque para alterar seu apelido",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  _obterNumero(context);
                },
                child: Text(
                  _numero != null ? _numero : "Toque para indicar seu numero",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue,
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: ButtonBar(children: [
                  RaisedButton(
                    color: Colors.lightBlue,
                    child: Row(
                      children: [
                        Text(
                          "Prosseguir",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    onPressed: () {
                      if (_apelido != null && _numero != null) {
                        this._candidato = Candidato.gerarNovo(
                          json.decode(widget.eleitor.requererCandidatura()),
                          _apelido,
                          _numero,
                        );
                        salvarDados();
                        carregarDados(widget.eleitor);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    new Candidatura(_candidato)));
                      } else {
                        alerta(
                          context,
                          mensagem: "Preencha os campos apelido e numero",
                          titulo: "Candidatos não podem ser anonimos",
                          botao: "Entendi",
                        );
                      }
                    },
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
