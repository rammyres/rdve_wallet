import 'dart:typed_data';

import 'package:hash/hash.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:bs58/bs58.dart';

String gerarEndereco(PublicKey chavePublica) {
  //Gera o endereço a partir de uma chave pública ECDSA
  var _cPub =
      '04${chavePublica.toHex()}'; //Adiciona 04 ao inicio da chave publica
  var _hash256 =
      SHA256().update(_cPub.codeUnits); // Gera um hash via sha256 a partir do
  var _hash160 = RIPEMD160().update(_hash256.digest());
  print(Uint8List.fromList(_hash160.digest()).toString());
  var _enderecoPublicoA = [
    00,
  ];
  _enderecoPublicoA.addAll(_hash160.digest());
  _hash256 = SHA256().update(_enderecoPublicoA.toString().codeUnits);
  var checksum = SHA256().update(_hash256.toString().codeUnits);

  _enderecoPublicoA.addAll(checksum.toString().codeUnits);

  var tmpEndPubB = Uint8List.fromList(_enderecoPublicoA.toString().codeUnits);
  var _enderecoPublicoB = base58.encode(tmpEndPubB);
  return _enderecoPublicoB.toString();
}

main() {
  var prKey = PrivateKey.generate();
  print(gerarEndereco(prKey.publicKey));
}
