import 'package:flutter/material.dart';
import 'package:rdve_wallet/componentes/usuario.dart';
import 'package:rdve_wallet/modelos/eleitor.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dialogoAlerta.dart';

class NovoUsuario extends StatefulWidget {
  @override
  _NovoUsuarioState createState() => _NovoUsuarioState();
}

class _NovoUsuarioState extends State<NovoUsuario> {
  var textoAviso = "";
  var corTexto = Colors.blueAccent;

  Future<void> salvarDados(Eleitor eleitor) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nome', eleitor.nome);
    prefs.setString('endereco', eleitor.endereco);
    prefs.setString('id', eleitor.id);
    prefs.setString('chavePrivada', eleitor.chavePrivada.toHex());
    prefs.setString('chavePublica', eleitor.chavePrivada.publicKey.toHex());
  }

  _carregarUsuario() async {
    Eleitor _eleitor;
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('id').isNotEmpty) {
      setState(() {
        _eleitor = Eleitor(
          prefs.getString('id') ?? "",
          prefs.getString('nome') ?? "",
          prefs.getString('endereco') ?? "",
          PrivateKey.fromHex(prefs.getString('chavePrivada') ?? ""),
        );
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => new Usuario(_eleitor)),
      );
    }
  }

  TextEditingController controleNome;

  void aoMudar() {
    setState(() {
      this.textoAviso = controleNome.text.contains(" ")
          ? ""
          : "(Você deve digitar o nome completo)";
      this.corTexto =
          controleNome.text.contains(" ") ? Colors.blueAccent : Colors.red[600];
    });
  }

  void _novoEleitor(String nome) {
    var eleitor = Eleitor.gerarNovo(nome);
    print(eleitor.paraJson());
    salvarDados(eleitor);
    _carregarUsuario();
  }

  @override
  void initState() {
    _carregarUsuario();
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
          FlatButton(
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
