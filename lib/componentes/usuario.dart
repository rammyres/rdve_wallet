import 'package:flutter/material.dart';
import 'package:rdve_wallet/componentes/dialogoRequisicaoDeVotacao.dart';
import 'package:rdve_wallet/componentes/novaCandidatura.dart';
import 'package:rdve_wallet/componentes/novoMesario.dart';
import 'package:rdve_wallet/componentes/novoUsuario.dart';
import 'package:rdve_wallet/modelos/eleitor.dart';
import 'package:rdve_wallet/componentes/dialogoRequisicaoCadastramento.dart';
import 'package:rdve_wallet/rotas/rotas.dart';

class Usuario extends StatefulWidget {
  Eleitor eleitor;
  Usuario(BuildContext ctx) {
    this.eleitor = ModalRoute.of(ctx).settings.arguments as Eleitor;
  }

  @override
  _UsuarioState createState() => _UsuarioState(this.eleitor);
}

class _UsuarioState extends State<Usuario> {
  final Eleitor eleitor;
  _UsuarioState(this.eleitor);

  void _irParaCandidatura(BuildContext context) {
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => new NovaCandidatura(this.eleitor)));
    Navigator.pushNamed(
      context,
      Rotas.NOVA_CANDIDATURA,
      arguments: eleitor,
    );
  }

  void _irParaOperacao(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => new NovoMesario(this.eleitor)));
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                Column(
                  children: [
                    ButtonBar(
                      buttonMinWidth: MediaQuery.of(context).size.width / 3,
                      buttonPadding: EdgeInsets.all(10),
                      alignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          color: Colors.lightBlue,
                          child: Column(
                            children: [
                              Icon(
                                Icons.cached,
                                size: 40,
                                color: Colors.white,
                              ),
                              Text(
                                "Alistamento",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
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
                          child: Column(
                            children: [
                              Icon(
                                Icons.how_to_vote,
                                size: 40,
                                color: Colors.white,
                              ),
                              Text(
                                "Votar",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
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
                    ButtonBar(
                      buttonMinWidth: MediaQuery.of(context).size.width / 3,
                      buttonPadding: EdgeInsets.all(10),
                      alignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          color: Colors.lightBlue,
                          child: Column(
                            children: [
                              Icon(
                                Icons.account_box,
                                size: 40,
                                color: Colors.white,
                              ),
                              Text(
                                "Sou mesário",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            _irParaOperacao(context);
                          },
                        ),
                        RaisedButton(
                          color: Colors.lightBlue,
                          child: Column(
                            children: [
                              Icon(
                                Icons.account_box_outlined,
                                size: 40,
                                color: Colors.white,
                              ),
                              Text(
                                "Sou candidato",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            _irParaCandidatura(context);
                          },
                        ),
                      ],
                    ),
                  ],
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
