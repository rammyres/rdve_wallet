import 'dart:convert';
import 'package:convert/convert.dart';

import 'package:secp256k1/secp256k1.dart';

import 'eleitor.dart';

class Mesario {
  String id;
  String nome;
  PrivateKey chavePrivada;

  Mesario(this.id, this.nome, this.chavePrivada);

  Mesario.gerarNovo(Eleitor eleitor) {
    this.id = eleitor.id;
    this.nome = eleitor.nome;
    this.chavePrivada = eleitor.chavePrivada;
  }

  String _assinar(String mensagem) {
    return this.chavePrivada.signature(mensagem).toString();
  }

  String mensagemParaUrna(String tipoMensagem) {
    var timestamp = DateTime.now().microsecondsSinceEpoch.toString();

    var dados =
        hex.encode("mensagemUrna:$id:$timestamp:$tipoMensagem".codeUnits);

    return json.encode(
      {
        "header": "mensagemUrna",
        "tipoMensage": tipoMensagem,
        "id_mesario": this.id,
        "timestamp": timestamp,
        "assinatura": this._assinar(dados)
      },
    );
  }
}
