import 'package:flutter/material.dart';
import 'package:rdve_wallet/componentes/usuario.dart';
import 'package:rdve_wallet/modelos/eleitor.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> _alerta({String mensagem, String botao}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(mensagem),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(botao),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  TextEditingController controleNome;

  void aoMudar() {
    setState(() {
      this.textoAviso = controleNome.text.contains(" ")
          ? ""
          : "(Você deve digitar o nome completo)";
      this.corTexto = controleNome.text.contains(" ")
          ? Colors.blueAccent
          : Colors.redAccent;
    });
  }

  void novoEleitor(String nome) {
    var eleitor = Eleitor.gerarNovo(nome);
    print(eleitor.paraJson());
    salvarDados(eleitor);
    _carregarUsuario();
  }

  bool estaVazio() {
    bool teste;
    setState(() {
      teste = controleNome.text == '';
    });
    return teste;
  }

  @override
  void initState() {
    _carregarUsuario();
    controleNome = TextEditingController();
    //controleNome.addListener(() => aoMudar());
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
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Spacer(),
          TextField(
            controller: controleNome,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: corTexto),
              ),
              labelText: 'Nome do eleitor $textoAviso',
            ),
            onChanged: (texto) => aoMudar(),
          ),
          FlatButton(
            child: Text(
              "Adicionar",
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
            onPressed: () {
              estaVazio()
                  ? _alerta(
                      mensagem:
                          "O nome do eleitor não pode estar vazio. Inclua o nome do eleitor e tente novamente",
                      botao: "entendi",
                    )
                  : novoEleitor(controleNome.text);
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}
