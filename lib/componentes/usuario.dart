import 'package:flutter/material.dart';
import 'package:rdve_wallet/modelos/eleitor.dart';

class Usuario extends StatefulWidget {
  Eleitor eleitor;
  Usuario(this.eleitor);
  @override
  _UsuarioState createState() => _UsuarioState(this.eleitor);
}

class _UsuarioState extends State<Usuario> {
  Eleitor eleitor;
  _UsuarioState(this.eleitor);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Oi ${this.eleitor.nome}",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
      ),
      body: Container(
        child: SizedBox.expand(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "ID do Eleitor: ",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      this.eleitor.id,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Image(
                  image: AssetImage("assets/imgs/usuario1.png"),
                  width: 280,
                ),
                Spacer(flex: 1),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        color: Colors.lightBlue,
                        child: Text(
                          "Solicitar cadastramento",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      RaisedButton(
                        color: Colors.lightBlue,
                        child: Text(
                          "Votar",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
