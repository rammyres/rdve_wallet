import 'dart:typed_data';

import 'package:secp256k1/secp256k1.dart';
import 'package:uuid/uuid.dart';
import 'package:bs58/bs58.dart';
import 'dart:math';

class Eleitor {
  String id;
  String nome;
  String numero;
  String endereco;
  PrivateKey chavePrivada;

  void gerarEndereco(PublicKey chavePublica) {
    var tmpBase58 =
        base58.encode(Uint8List.fromList(chavePublica.toHex().codeUnits));
  }

  Eleitor(this.id, this.nome, this.numero, this.endereco, this.chavePrivada);

  Eleitor.gerarNovo(this.nome) {
    var novaId = Uuid();
    this.numero = Random().nextInt(9999999999).toString();
    this.id = novaId.v4();
    this.chavePrivada = PrivateKey.generate();
  }

  String assinar(String mensagem) {
    return this.chavePrivada.signature(mensagem).toString();
  }

  Map<String, String> paraJson() {
    return {
      'id': this.id,
      'nome': this.nome,
      'numero': this.numero,
      'chavePublica': this.chavePrivada.publicKey.toString(),
    };
  }
}
