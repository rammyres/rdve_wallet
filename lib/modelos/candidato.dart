import 'dart:convert';
import 'package:bs58/bs58.dart';
import 'package:convert/convert.dart';
import 'package:hash/hash.dart';
import 'package:secp256k1/secp256k1.dart';

class Candidato {
  String id;
  String numero;
  String apelido;
  String endereco;
  Map requisicao;
  PrivateKey chavePrivada;

  Candidato(
    this.id,
    this.numero,
    this.apelido,
    this.endereco,
    chavePrivada,
    requisicao,
  ) {
    this.requisicao = json.decode(requisicao);
    this.chavePrivada = PrivateKey.fromHex(chavePrivada);
  }

  Candidato.gerarNovo(this.requisicao, this.apelido, this.numero) {
    this.id = this.requisicao["id"];
    this.chavePrivada = PrivateKey.generate();
    this.endereco = gerarEndereco(this.chavePrivada.publicKey);
  }

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

  String _assinar(String mensagem) {
    return this.chavePrivada.signature(mensagem).toString();
  }

  String registroCandidatura() {
    String timestamp = DateTime.now().microsecondsSinceEpoch.toString();
    String dados = hex.encode(
        "registrocandidatura:${this.id}:${this.apelido}:${this.endereco}$timestamp"
            .codeUnits);
    return json.encode(
      {
        "header": "registroCandidatura",
        "id": this.id,
        "numero": this.numero,
        "apelido": this.apelido,
        "endereco": this.endereco,
        "timestamp": timestamp,
        "chavePublica": this.chavePrivada.publicKey.toHex(),
        "assinatura": this._assinar(dados),
      },
    );
  }
}
