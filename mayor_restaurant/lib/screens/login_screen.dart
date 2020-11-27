// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mayor_restaurant/screens/cardapio_screen.dart';

class LoginPageState extends StatefulWidget {

  @override
  LoginScreen createState() => new LoginScreen();
}

class LoginScreen extends State<LoginPageState> {

  LoginScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 30, right: 10, left: 10, bottom: 20,
            ),
            child: Image.asset(
              'imagens/LogoMR.png',
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 20, right: 25, left: 25, bottom: 20,
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA80003))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff2B8309))),
                      hintText: 'Usuário ou E-Mail',
                      hintStyle: TextStyle(color: Color(0xff2B8309))),
                ),
                TextField(
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA80003))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff2B8309))),
                      hintText: 'Senha',
                      hintStyle: TextStyle(color: Color(0xff2B8309))),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 20, right: 20, left: 20, bottom: 20,
            ),
            child: Column(
              children: [
                RaisedButton(
                  padding: EdgeInsets.only(
                    top: 20, right: 165, left: 165, bottom: 20,
                  ),
                  child: Text('Entrar'),
                  color: Color(0xff2B8309),
                  textColor: Colors.white,
                  splashColor: Color(0xffA80003),
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => CardapioPageState())
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
