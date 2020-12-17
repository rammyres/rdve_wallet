import 'package:flutter/material.dart';

Future<void> alerta(BuildContext context,
    {String titulo, String mensagem, String botao}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo ?? "Erro"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(mensagem),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(botao),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
