import 'dart:convert';

import 'package:hash/hash.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:uuid/uuid.dart';
import 'package:convert/convert.dart';
import 'package:bs58/bs58.dart';

class Eleitor {
  String id;
  String nome;
  String endereco;
  PrivateKey chavePrivada;

  Eleitor();

  Eleitor.novo(this.id, this.nome, this.endereco, this.chavePrivada);

  String gerarEndereco(PublicKey chavePublica) {
    //Gera o endereço a partir de uma chave pública ECDSA
    var _cPub =
        '04${chavePublica.toHex()}'; //Adiciona 04 ao inicio da chave publica
    var _hash256 = SHA256()
        .update(_cPub.codeUnits)
        .digest(); // Gera um hash via sha256 a partir da chave publica alterada
    var _hash160 = RIPEMD160()
        .update(_hash256); //Gera um hash RIPEMD160 a partir do hash anterior

    var _enderecoPublicoA =
        '${hex.encode('x00'.codeUnits)}${hex.encode(_hash160.digest()).toString()}';
    //O endereço A (não comprimido) é gerado com a inclusão do caracter nulo no
    //começo da string e a inclusão do hash RIPEMD160 ao fim

    _hash256 = SHA256().update(_enderecoPublicoA.codeUnits).digest();
    //É atualizado o hash sha256 com o conteúdo do endereço não comprimido

    var _checksum =
        hex.encode(SHA256().update(_hash256.toString().codeUnits).digest());
    //É gerado o código verificador a partir dos 4 últimos dígitos do hash 256
    //do hash anterior

    //O hash é então codificado em base58
    var _enderecoPublicoB = base58.encode(hex.decode(
        '$_enderecoPublicoA${_checksum.toString().substring(_checksum.length - 4, _checksum.length)}'));
    return _enderecoPublicoB;
  }

  Eleitor.gerarNovo(this.nome) {
    var novaId = Uuid();
    this.id = novaId.v4();
    this.chavePrivada = PrivateKey.generate();
    this.endereco = gerarEndereco(this.chavePrivada.publicKey);
  }

  String _assinar(String mensagem) {
    return this.chavePrivada.signature(mensagem).toString();
  }

  String requisicaoDeVotacao() {
    String timestamp = DateTime.now().microsecondsSinceEpoch.toString();

    String dados = hex.encode(
        "requisitaVoto:${this.id}:${this.endereco}:$timestamp".codeUnits);

    return json.encode({
      'header': 'requisitaVoto',
      'id': this.id,
      'endereco': this.endereco,
      'timestamp': timestamp,
      'assinatura': this._assinar(dados),
    });
  }

  String requererCandidatura() {
    String timestamp = DateTime.now().microsecondsSinceEpoch.toString();
    String dados =
        hex.encode("requisitaCandidatura:${this.id}$timestamp".codeUnits);
    return json.encode(
      {
        "header": "requisitaCandidatura",
        "id": this.id,
        "timestamp": timestamp,
        "assinatura": this._assinar(dados),
      },
    );
  }

  String paraJson() {
    return json.encode({
      'header': 'requisitaAlistamento',
      'id': this.id,
      'nome': this.nome,
      'endereco': this.endereco,
      'chavePublica': this.chavePrivada.publicKey.toString(),
    });
  }
}
