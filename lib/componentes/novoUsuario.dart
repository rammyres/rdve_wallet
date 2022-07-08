import 'package:flutter/material.dart';

import 'package:rdve_wallet/modelos/eleitor.dart';

import 'package:rdve_wallet/modelos/cores.dart';
import 'dialogoAlerta.dart';
import 'package:rdve_wallet/utils/preferencias.dart';

class NovoUsuario extends StatefulWidget {
  @override
  _NovoUsuarioState createState() => _NovoUsuarioState();
}

class _NovoUsuarioState extends State<NovoUsuario> {
  Preferencias prefs = Preferencias.sincronizar() as Preferencias;
  var textoAviso = "";
  var corTexto = Cores.azulEnfase;

  TextEditingController controleNome;

  void aoMudar() {
    setState(() {
      this.textoAviso = controleNome.text.contains(" ")
          ? ""
          : "(Você deve digitar o nome completo)";
      this.corTexto =
          controleNome.text.contains(" ") ? Cores.azul : Cores.vermelho[600];
    });
  }

  void _novoEleitor(String nome) {
    var eleitor = Eleitor.gerarNovo(nome);
    print(eleitor.paraJson());
    this.prefs.salvarDados(eleitor);
    this.prefs.carregarUsuario();
  }

  @override
  void initState() {
    this.prefs.carregarUsuario();
    controleNome = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo eleitor"),
      ),
      body: Column(
        children: [
          Text(
            "Parece que ainda não existe eleitor cadastrado. Vamos cadastrar você agora.",
            style: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Spacer(),
          TextField(
            controller: controleNome,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: corTexto, width: 3.0),
              ),
              hintText: "Insira o nome completo do eleitor",
              labelText: 'Nome do eleitor $textoAviso',
              labelStyle: TextStyle(color: corTexto),
            ),
            onChanged: (texto) => aoMudar(),
          ),
          TextButton(
            child: Text(
              "Adicionar",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            onPressed: () {
              controleNome.text.isEmpty
                  ? alerta(
                      context,
                      mensagem:
                          "O nome do eleitor não pode estar vazio. Inclua o nome do eleitor e tente novamente",
                      botao: "entendi",
                    )
                  : _novoEleitor(controleNome.text);
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}
