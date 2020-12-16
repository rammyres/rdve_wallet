import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rdve_wallet/modelos/eleitor.dart';

class DialogoRequisicaoCadastramento extends StatelessWidget {
  final Eleitor eleitor;
  DialogoRequisicaoCadastramento(this.eleitor);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            Text(
                "Para solicitar o cadastramento mostre este QR Code para o equipamento"),
            QrImage(
              data: eleitor.paraJson(),
              size: MediaQuery.of(context).size.width * 0.76,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                child: Text("Sair"),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
