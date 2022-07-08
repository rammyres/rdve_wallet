import 'package:rdve_wallet/modelos/eleitor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:secp256k1/secp256k1.dart';
import "dart:async";

class Preferencias {
  Eleitor eleitor;
  SharedPreferences prefs;
  bool inicializado = false;

  Preferencias._sincronizar(SharedPreferences p) {
    this.prefs = p;
  }

  static Future<Preferencias> sincronizar() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var preferencias = Preferencias._sincronizar(p);
    return preferencias;
  }

  Future<void> salvarDados(Eleitor eleitor) async {
    prefs.setString('nome', eleitor.nome);
    prefs.setString('endereco', eleitor.endereco);
    prefs.setString('id', eleitor.id);
    prefs.setString('chavePrivada', eleitor.chavePrivada.toHex());
    prefs.setString('chavePublica', eleitor.chavePrivada.publicKey.toHex());
  }

  Future<void> carregarUsuario() async {
    bool st = this.prefs.containsKey("id");
    if (st) {
      eleitor = Eleitor(
        prefs.getString('id') ?? "",
        prefs.getString('nome') ?? "",
        prefs.getString('endereco') ?? "",
        PrivateKey.fromHex(prefs.getString('chavePrivada') ?? ""),
      );
      inicializado = true;
    }
  }
}
