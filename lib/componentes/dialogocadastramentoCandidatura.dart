import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rdve_wallet/modelos/candidato.dart';

class DialogoCadastramentoCandidatura extends StatelessWidget {
  final Candidato candidato;
  DialogoCadastramentoCandidatura(this.candidato);
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
              data: candidato.registroCandidatura(),
              size: MediaQuery.of(context).size.width * 0.7,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                child: Text(
                  "Sair",
                  style: TextStyle(
                    color: Colors.lightBlue[500],
                    fontSize: 20,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
