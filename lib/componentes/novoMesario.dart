import 'package:flutter/material.dart';
import 'package:rdve_wallet/componentes/avisoCandidatoMesario.dart';
import 'package:rdve_wallet/componentes/novoUsuario.dart';
import 'package:rdve_wallet/componentes/operador.dart';
import 'package:rdve_wallet/modelos/eleitor.dart';
import 'package:rdve_wallet/modelos/mesario.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NovoMesario extends StatefulWidget {
  final Eleitor _eleitor;
  NovoMesario(this._eleitor);
  @override
  _NovoMesarioState createState() => _NovoMesarioState();
}

class _NovoMesarioState extends State<NovoMesario> {
  Mesario _mesario;
  bool ehCandidato;
  bool ehMesario;

  Future<void> salvarDados() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('ehMesario', true);
  }

  carregarDados(Eleitor eleitor) async {
    final prefs = await SharedPreferences.getInstance();
    this.ehCandidato = prefs.getBool("ehCandidato") ?? false;
    this.ehMesario = prefs.getBool("ehMesario") ?? false;

    if (ehMesario && !ehCandidato) {
      setState(
        () {
          this._mesario = Mesario(
            prefs.getString("id") ?? "",
            prefs.getString("nome") ?? "",
            PrivateKey.fromHex(prefs.getString("chavePrivada")),
          );
        },
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => new Operador(_mesario),
        ),
      );
    }

    if (!ehMesario && ehCandidato) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => new AvisoCandidatoMesario(),
        ),
      );
    }

    // if (!ehMesario && !ehCandidato) {
    //   this._mesario = Mesario.gerarNovo(widget._eleitor);
    // }
  }

  void _voltarTelaInicial(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => new NovoUsuario(),
      ),
    );
  }

  @override
  void initState() {
    carregarDados(widget._eleitor);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _voltarTelaInicial(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Registro de mesário",
            style: TextStyle(
              fontSize: 28,
            ),
          ),
        ),
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "ID do eleitor: ${widget._eleitor.id}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(
                flex: 1,
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Text(
                  "Parece que você é um mesário, para registrar sua condição clique no botão abaixo",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Spacer(
                flex: 1,
              ),
              ButtonTheme(
                height: MediaQuery.of(context).size.height / 9,
                child: RaisedButton(
                  color: Colors.blueAccent[400],
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_box,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.height / 10,
                      ),
                      Text(
                        "Sou mesário",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    this._mesario = Mesario(
                      widget._eleitor.id,
                      widget._eleitor.nome,
                      widget._eleitor.chavePrivada,
                    );
                    salvarDados();
                    carregarDados(widget._eleitor);
                  },
                ),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
