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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Operação da urna",
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Opções anteriores ao dia da votação",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text(
                    "Liberar alistamento eleitoral",
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
                  child: Text(
                    "Liberar registro de candidatura",
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
              alignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text(
                    "Iniciar a votação",
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
                  child: Text(
                    "Liberar urna para eleitor",
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
                  child: Text(
                    "Encerrar a votação",
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
    );
  }
}
