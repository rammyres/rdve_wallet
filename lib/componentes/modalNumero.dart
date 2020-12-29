import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:rdve_wallet/componentes/dialogoAlerta.dart';

class ModalNumero extends StatefulWidget {
  final Function(String) _aoEnviar;
  //final Function(String) _proxTela;

  ModalNumero(this._aoEnviar);
  @override
  _ModalNumeroState createState() => _ModalNumeroState();
}

class _ModalNumeroState extends State<ModalNumero> {
  TextEditingController numero = TextEditingController();

  void _aoEnviar() {
    if (numero.text.isEmpty) {
      alerta(
        context,
        titulo: "Não pode estar vazio",
        mensagem: "Não é possível cadastrar um candidato sem número",
        botao: "Entendi",
      );
      return;
    }
    setState(() {
      widget._aoEnviar(numero.text);
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
                  Text("Digite o numero da sua chapa"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PinInputTextField(
                        controller: numero,
                        pinLength: 2,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.go,
                        decoration: BoxLooseDecoration(
                          strokeColorBuilder: PinListenColorBuilder(
                            Colors.cyan,
                            Colors.green,
                          ),
                        ),
                        onSubmit: (n) => _aoEnviar(),
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      "OK",
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
