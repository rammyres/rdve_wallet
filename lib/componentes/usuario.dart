import 'package:flutter/material.dart';
import 'package:rdve_wallet/componentes/novoUsuario.dart';
import 'package:rdve_wallet/modelos/eleitor.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Usuario extends StatefulWidget {
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  Eleitor eleitor;

  _carregarUsuario() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      this.eleitor = Eleitor(
        prefs.getString('id') ?? '',
        prefs.getString('nome') ?? '',
        prefs.getString('endereco') ?? '',
        PrivateKey.fromHex(prefs.getString('chavePrivada') ?? ''),
      );
      print(this.eleitor.id);
      print(prefs.getString('id') ?? 'Hey!');
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (this.eleitor.id == '') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NovoUsuario()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _carregarUsuario(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Oi ${this.eleitor.nome}",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
            body: SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "ID do Eleitor: ",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        this.eleitor.id,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Image(
                    image: AssetImage("assets/imgs/usuario1.png"),
                    width: 280,
                  ),
                  Spacer(),
                ],
              ),
            ),
          );
        });
  }
}
