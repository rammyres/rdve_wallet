import 'package:flutter/material.dart';

import 'package:rdve_wallet/componentes/dialogoAlerta.dart';

class ModalApelido extends StatefulWidget {
  final Function(String) _aoEnviar;

  ModalApelido(this._aoEnviar);
  @override
  _ModalApelidoState createState() => _ModalApelidoState();
}

class _ModalApelidoState extends State<ModalApelido> {
  TextEditingController apelido = TextEditingController();

  void _aoEnviar() {
    if (apelido.text.isEmpty) {
      alerta(
        context,
        titulo: "Não pode estar vazio",
        mensagem: "Não é possível cadastrar um candidato sem apelido",
        botao: "Entendi",
      );
      return;
    }
    setState(() {
      widget._aoEnviar(apelido.text);
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            child: SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Digite o apelido do cadidato"),
                  TextField(
                    controller: apelido,
                    decoration: InputDecoration(labelText: "Apelido"),
                    onSubmitted: (n) => _aoEnviar(),
                  ),
                  RaisedButton(
                    child: Text(
                      "Ok",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () => _aoEnviar(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
