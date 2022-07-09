import 'package:rdve_wallet/modelos/eleitor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:secp256k1/secp256k1.dart';
import "dart:async";

class Preferencias {
  Eleitor eleitor;
  Map<String, dynamic> prefs = {};
  bool inicializado = false;

  Preferencias() {
    carregarUsuario();
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
    SharedPreferences p = await SharedPreferences.getInstance();
    this.prefs = {
      "id": p.getString("id") ?? "",
      "nome": p.getString("nome") ?? "",
      "endereco": p.getString("endereco") ?? "",
      "chavePrivada": p.getString("chavePrivada") ?? ""
    };
    if (this.prefs["id"] != "") {
      this.eleitor = Eleitor.novo(
          this.prefs['id'] ?? "",
          this.prefs["nome"] ?? "",
          this.prefs["endereco"] ?? "",
          PrivateKey.fromHex(this.prefs['chavePrivada']) ?? "");
      inicializado = true;
    }
    // SharedPreferences lPrefs = await SharedPreferences.getInstance();
    // bool st = lPrefs.containsKey("id");
    // if (st) {
    //   eleitor = Eleitor.novo(
    //     lPrefs.getString('id') ?? "",
    //     lPrefs.getString('nome') ?? "",
    //     lPrefs.getString('endereco') ?? "",
    //     PrivateKey.fromHex(lPrefs.getString('chavePrivada') ?? ""),
    //   );
    //   inicializado = true;
    // }
  }
}
