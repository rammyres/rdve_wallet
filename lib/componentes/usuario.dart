import 'package:flutter/material.dart';
import 'package:rdve_wallet/componentes/dialogoRequisicaoDeVotacao.dart';
import 'package:rdve_wallet/componentes/novaCandidatura.dart';
import 'package:rdve_wallet/modelos/eleitor.dart';
import 'package:rdve_wallet/componentes/dialogoRequisicaoCadastramento.dart';

class Usuario extends StatefulWidget {
  final Eleitor eleitor;
  Usuario(this.eleitor);
  @override
  _UsuarioState createState() => _UsuarioState(this.eleitor);
}

class _UsuarioState extends State<Usuario> {
  final Eleitor eleitor;
  _UsuarioState(this.eleitor);

  void _irParaCandidatura(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => new NovaCandidatura(this.eleitor)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Oi ${this.eleitor.nome.substring(0, this.eleitor.nome.indexOf(" "))}",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: Container(
        child: SizedBox.expand(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
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
                Spacer(flex: 1),
                Container(
                  child: ButtonBar(
                    buttonPadding: EdgeInsets.all(10),
                    alignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        color: Colors.lightBlue,
                        child: Text(
                          "Solicitar cadastramento",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return DialogoRequisicaoCadastramento(eleitor);
                            },
                          );
                        },
                      ),
                      RaisedButton(
                        color: Colors.lightBlue,
                        child: Text(
                          "Votar",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return DialogoRequisicaoDeVotacao(eleitor);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  color: Colors.lightBlue,
                  child: Text(
                    "Ver informações sobre candidatura",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    _irParaCandidatura(context);
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
