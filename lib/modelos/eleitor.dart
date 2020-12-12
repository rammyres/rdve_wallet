import 'package:hash/hash.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:uuid/uuid.dart';
import 'package:bs58/bs58.dart';

class Eleitor {
  String id;
  String nome;
  String numero;
  String endereco;
  PrivateKey chavePrivada;

  String gerarEndereco(PublicKey chavePublica) {
    //Gera o endereço a partir de uma chave pública ECDSA
    var _cPub =
        '04${chavePublica.toHex()}'; //Adiciona 04 ao inicio da chave publica
    var _hash256 =
        SHA256().update(_cPub.codeUnits); // Gera um hash via sha256 a partir do
    var _hash160 = RIPEMD160().update(_hash256.toString().codeUnits);
    var _enderecoPublicoA = [
      00,
    ];
    _enderecoPublicoA.addAll(_hash160.toString().codeUnits);
    _hash256 = SHA256().update(_enderecoPublicoA.toString().codeUnits);
    var checksum = SHA256().update(_hash256.toString().codeUnits);

    _enderecoPublicoA.addAll(checksum.toString().codeUnits);

    var _enderecoPublicoB =
        base58.encode(_enderecoPublicoA.toString().codeUnits);
    return _enderecoPublicoB.toString();
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
