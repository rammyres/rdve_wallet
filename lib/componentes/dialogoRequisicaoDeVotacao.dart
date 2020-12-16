import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rdve_wallet/modelos/eleitor.dart';

class DialogoRequisicaoDeVotacao extends StatelessWidget {
  final Eleitor eleitor;
  DialogoRequisicaoDeVotacao(this.eleitor);
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
            Text("Para iniciar a votação mostre o QR Code abaixo para a Urna"),
            QrImage(
              data: eleitor.requisicaoDeVotacao(),
              size: MediaQuery.of(context).size.width * 0.76,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Sair",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.lightBlue[500],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
