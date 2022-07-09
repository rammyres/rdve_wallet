import 'package:flutter/material.dart';
import 'package:rdve_wallet/modelos/cores.dart';
import 'package:rdve_wallet/rotas/rotas.dart';
import 'package:rdve_wallet/utils/preferencias.dart';

class TelaDeBoasVindas extends StatelessWidget {
  Preferencias prefs = Preferencias();
  final BuildContext ctx;

  Future<void> carregarPrefs() async {
    Preferencias prefs = Preferencias();
    print(prefs);
    this.prefs = prefs;
  }

  void _verificarUsuario() {
    carregarPrefs();
    if (prefs.inicializado) {
      Navigator.pushReplacementNamed(
        ctx,
        Rotas.TELA_USUARIO,
        arguments: prefs.eleitor,
      );
    }
  }

  TelaDeBoasVindas(this.ctx) {
    _verificarUsuario();
  }

  @override
  Widget build(BuildContext context) {
    void _novoUsuario() {
      Navigator.pushNamed(context, Rotas.NOVO_USUARIO);
    }

    return Scaffold(
      appBar: AppBar(title: Text("Bem vindo a RDVE Wallet")),
      body: Card(
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: Text(
                  "Bem vindo a RDVE Wallet",
                  style: TextStyle(fontSize: 26, color: Cores.azul),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    "A RDVE Wallet é a carteira de identificação" +
                        "e painel de controle do projeto RDVE." +
                        "Com ela você poderá gerar sua identificação" +
                        "e operar as urnas do projeto.",
                    style: TextStyle(fontSize: 20, color: Cores.azul),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    "Para iniciar seu uso clique em adicionar usuário",
                    style: TextStyle(fontSize: 20, color: Cores.azul),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(100, 100) // put the width and height you want
                    ),
                onPressed: _novoUsuario,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.add),
                      Text("Adicionar Usuário"),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
