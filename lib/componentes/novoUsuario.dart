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
    print(prefs.getString('id'));
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'O nome do eleitor não pode estar vazio. Inclua o nome do eleitor e tente novamente'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Entendi'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final controleNome = TextEditingController();

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
              "Parece que ainda não existe eleitor cadastrado vamos cadastrar você agora",
              style: TextStyle(fontSize: 18),
            ),
            Spacer(),
            TextField(
              controller: controleNome,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome do eleitor',
              ),
            ),
            FlatButton(
              child: Text(
                "Adicionar",
                style: TextStyle(fontSize: 18, color: Colors.blue),
              ),
              onPressed: () {
                estaVazio() ? _showMyDialog() : novoEleitor(controleNome.text);
              },
            ),
            Spacer(),
          ],
        ));
  }
}
