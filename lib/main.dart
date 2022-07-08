import 'package:flutter/material.dart';
import 'package:rdve_wallet/componentes/boas_vindas.dart';
import 'package:rdve_wallet/componentes/novaCandidatura.dart';
import 'package:rdve_wallet/componentes/novoUsuario.dart';
import 'package:rdve_wallet/componentes/usuario.dart';
import 'rotas/rotas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RDVE Wallet',
      theme: ThemeData(
        buttonBarTheme: ButtonBarThemeData(
          buttonHeight: 60,
        ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Rotas.BOAS_VINDAS,
      routes: {
        Rotas.BOAS_VINDAS: (ctx) => TelaDeBoasVindas(ctx),
        Rotas.NOVO_USUARIO: (ctx) => NovoUsuario(),
        Rotas.NOVA_CANDIDATURA: (ctx) => NovaCandidatura(ctx),
        Rotas.TELA_USUARIO: (ctx) => Usuario(ctx),
      },
    );
  }
}
