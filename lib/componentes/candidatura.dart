import 'package:flutter/material.dart';

import 'package:rdve_wallet/componentes/modalQR.dart';
import 'package:rdve_wallet/componentes/novoUsuario.dart';
import 'package:rdve_wallet/modelos/candidato.dart';

class Candidatura extends StatelessWidget {
  final Candidato _candidato;

  Candidatura(this._candidato);

  void _mostrarModalQR({BuildContext context, String mensagem, String dados}) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return ModalQR(
          mensagem: mensagem,
          dados: dados,
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
          actions: [
            FlatButton.icon(
              onPressed: () {
                _voltarTelaInicial(context);
              },
              icon: Icon(Icons.arrow_back_ios_outlined),
              label: Text(""),
            )
          ],
          title: Text(
            "Candidatura de ${this._candidato.apelido}",
            style: TextStyle(
              fontSize: 22,
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
                        this._candidato.id,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Image(
                    image: AssetImage("assets/imgs/candidato1.png"),
                    width: 280,
                  ),
                  Text(
                    "${this._candidato.numero} - ${this._candidato.apelido}",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(flex: 1),
                  Container(
                    child: ButtonBar(
                      buttonPadding: EdgeInsets.all(10),
                      alignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          color: Colors.lightBlue,
                          child: Column(
                            children: [
                              Icon(
                                Icons.wysiwyg,
                                size: 50,
                                color: Colors.white,
                              ),
                              Text(
                                "Registrar",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            _mostrarModalQR(
                              context: context,
                              mensagem:
                                  "Para efetuar o registro da sua candidatura mostre o QR Code abaixo para o equipamento de coleta",
                              dados: _candidato.registroCandidatura(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
