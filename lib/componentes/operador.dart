import 'package:flutter/material.dart';
import 'package:rdve_wallet/componentes/modalMesario.dart';
import 'package:rdve_wallet/componentes/novoUsuario.dart';
import 'package:rdve_wallet/modelos/mesario.dart';

class Operador extends StatelessWidget {
  final Mesario _mesario;
  Operador(this._mesario);

  dialogoMensagem({BuildContext contexto, String tipoMensagem}) {
    showModalBottomSheet(
      context: contexto,
      builder: (ctx) {
        return DialogoMensagem(
          this._mesario.mensagemParaUrna(tipoMensagem),
        );
      },
    );
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _voltarTelaInicial(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Menu do operador",
            style: TextStyle(fontSize: 28),
          ),
        ),
        body: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(
                flex: 1,
              ),
              Text(
                "Opções anteriores ao dia da votação",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonPadding: EdgeInsets.all(10),
                children: [
                  RaisedButton(
                    color: Colors.blueAccent,
                    child: Column(
                      children: [
                        Icon(
                          Icons.file_download,
                          color: Colors.white,
                          size: 40,
                        ),
                        Text(
                          "Liberar\nalistamento",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      dialogoMensagem(
                        contexto: context,
                        tipoMensagem: "libAlistamento",
                      );
                    },
                  ),
                  RaisedButton(
                    color: Colors.blueAccent,
                    child: Column(
                      children: [
                        Icon(
                          Icons.file_download_done,
                          color: Colors.white,
                          size: 40,
                        ),
                        Text(
                          "Registro de\ncandidatura",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      dialogoMensagem(
                        contexto: context,
                        tipoMensagem: "libCandidatura",
                      );
                    },
                  ),
                ],
              ),
              Spacer(
                flex: 3,
              ),
              Text(
                "Opções no dia da votação",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                buttonPadding: EdgeInsets.all(10),
                children: [
                  RaisedButton(
                    color: Colors.blueAccent,
                    child: Column(
                      children: [
                        Icon(
                          Icons.play_arrow,
                          size: 40,
                          color: Colors.white,
                        ),
                        Text(
                          "Iniciar\nvotação",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      dialogoMensagem(
                        contexto: context,
                        tipoMensagem: "iniciarVotacao",
                      );
                    },
                  ),
                  RaisedButton(
                    color: Colors.blueAccent,
                    child: Column(
                      children: [
                        Icon(
                          Icons.card_membership,
                          size: 40,
                          color: Colors.white,
                        ),
                        Text(
                          "Liberar\nvotação",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      dialogoMensagem(
                        contexto: context,
                        tipoMensagem: "libvotacao",
                      );
                    },
                  ),
                  RaisedButton(
                    color: Colors.blueAccent,
                    child: Column(
                      children: [
                        Icon(
                          Icons.stop,
                          size: 40,
                          color: Colors.white,
                        ),
                        Text(
                          "Encerrar\nvotação",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      dialogoMensagem(
                        contexto: context,
                        tipoMensagem: "encerraVotacao",
                      );
                    },
                  ),
                ],
              ),
              Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => new NovoUsuario(),
              ),
            );
          },
        ),
      ),
    );
  }
}
