import 'package:flutter/material.dart';
import 'package:rdve_wallet/componentes/novoUsuario.dart';

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
      home: NovoUsuario(),
    );
  }
}

class PaginaInicial extends StatelessWidget {
  final String titulo;

  PaginaInicial(this.titulo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: Container(
        margin: EdgeInsets.all(12),
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.account_box,
          size: 28,
        ),
        onPressed: () => {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
