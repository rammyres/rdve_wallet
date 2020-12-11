import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:hash/hash.dart';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:uuid/uuid.dart';
import 'package:bs58/bs58.dart';

class Eleitor {
  String id;
  String nome;
  String numero;
  String endereco;
  PrivateKey chavePrivada;

  void gerarEndereco(PublicKey chavePublica) {
    HexEncoder _hexEncoder;

    var _cPub = '04${chavePublica.toHex()}';
    var hash256 = SHA256().update(_cPub.codeUnits);
    var hash160 = RIPEMD160().update(hash256.toString().codeUnits);
    var header = []
    var enderecoPublico_a = _hexEncoder()

    var tmpBase58 =
        base58.encode(Uint8List.fromList(chavePublica.toHex().codeUnits));
  }

  Eleitor(this.id, this.nome, this.endereco, this.chavePrivada);

  Eleitor.gerarNovo(this.nome) {
    var novaId = Uuid();
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
