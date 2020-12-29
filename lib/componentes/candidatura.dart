import 'package:flutter/material.dart';
import 'package:rdve_wallet/componentes/dialogocadastramentoCandidatura.dart';
import 'package:rdve_wallet/modelos/candidato.dart';

class Candidatura extends StatelessWidget {
  final Candidato _candidato;

  Candidatura(this._candidato);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Candidatura de ${this._candidato.apelido}",
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
                              return DialogoCadastramentoCandidatura(
                                  _candidato);
                            },
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
    );
  }
}
