import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RDVE Wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PaginaInicial('Carteira RDVE'),
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
              Text(
                "Usuário",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.account_circle_rounded,
                color: Colors.blueGrey,
                size: 200,
              ),
              Text("Parece que ainda não há um usuário cadastrado"),
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
