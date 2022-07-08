import 'package:rdve_wallet/modelos/eleitor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:secp256k1/secp256k1.dart';
import "dart:async";
import 'dart:convert';

class Preferencias {
  Eleitor eleitor;
  Map<String, dynamic> prefs = Map();
  bool inicializado = false;

  Preferencias();
  Preferencias._sincronizar(SharedPreferences p) {
    this.prefs = json.decode(p.toString());
  }

  static Future<Preferencias> sincronizar() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var preferencias = Preferencias._sincronizar(p);
    return preferencias;
  }

  Future<void> salvarDados(Eleitor eleitor) async {
    SharedPreferences lPrefs = await SharedPreferences.getInstance();
    lPrefs.setString('nome', eleitor.nome);
    lPrefs.setString('endereco', eleitor.endereco);
    lPrefs.setString('id', eleitor.id);
    lPrefs.setString('chavePrivada', eleitor.chavePrivada.toHex());
    lPrefs.setString('chavePublica', eleitor.chavePrivada.publicKey.toHex());
  }

  Future<void> carregarUsuario() async {
    SharedPreferences lPrefs = await SharedPreferences.getInstance();
    bool st = lPrefs.containsKey("id");
    if (st) {
      eleitor = Eleitor.novo(
        lPrefs.getString('id') ?? "",
        lPrefs.getString('nome') ?? "",
        lPrefs.getString('endereco') ?? "",
        PrivateKey.fromHex(lPrefs.getString('chavePrivada') ?? ""),
      );
      inicializado = true;
    }
  }
}
