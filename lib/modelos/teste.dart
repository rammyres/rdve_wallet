import 'dart:convert';

import 'package:hash/hash.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:bs58/bs58.dart';
import 'package:convert/convert.dart';
import 'package:uuid/uuid.dart';

String gerarEndereco(PublicKey chavePublica) {
  //Gera o endereço a partir de uma chave pública ECDSA
  var _cPub =
      '04${chavePublica.toHex()}'; //Adiciona 04 ao inicio da chave publica
  var _hash256 = SHA256()
      .update(_cPub.codeUnits)
      .digest(); // Gera um hash via sha256 a partir da chave publica alterada
  var _hash160 = RIPEMD160().update(_hash256);

  var _enderecoPublicoA =
      '${hex.encode('x00'.codeUnits)}${hex.encode(_hash160.digest()).toString()}';

  _hash256 = SHA256().update(_enderecoPublicoA.codeUnits).digest();

  var _checksum =
      hex.encode(SHA256().update(_hash256.toString().codeUnits).digest());

  var _enderecoPublicoB = base58.encode(hex.decode(
      '$_enderecoPublicoA${_checksum.toString().substring(_checksum.length - 4, _checksum.length)}'));

  return _enderecoPublicoB;
}

String paraJson([
  String id,
  String nome,
  String endereco,
  PrivateKey chavePrivada,
]) {
  return json.encode({
    'id': id,
    'nome': nome,
    'endereco': endereco,
    'chavePublica': chavePrivada.publicKey.toString(),
  });
}

main() {
  var gerarUid = Uuid();
  var uuid = gerarUid.v4();
  var prKey = PrivateKey.generate();
  var endereco = gerarEndereco(prKey.publicKey);
  print(endereco);
  print(endereco.length);
  print(uuid.toString());
  var mapa = paraJson(uuid, "teste", endereco, prKey);
  print(mapa);
}
