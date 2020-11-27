import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mayor_restaurant/pedidoItem.dart';
import 'package:mayor_restaurant/screens/finalPedido_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PagamentoPageState extends StatefulWidget {

  final PedidoItem ped;

  PagamentoPageState(this.ped);

  @override
  PagamentoPedidoScreen createState() => new PagamentoPedidoScreen(this.ped);
}

class PagamentoPedidoScreen extends State<PagamentoPageState> {

  PedidoItem pedido;

  bool pagamentoDinheiro = false;
  bool pagamentoCartao = false;
  bool pagamentoVR = false;
  int contador = 0;

  @override
   void initState() {
    super.initState();
    inicializar();
  }

  inicializar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      contador = (prefs.getInt('contador') ?? 0);
    });
  }

  PagamentoPedidoScreen(this.pedido);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pague seu pedido'),
        backgroundColor: Color(0xff2B8309),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 50
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 20, bottom: 20,
                  ),
                  color: Color(0xffA80003),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              pedido.prato + ' - R\$ ' + pedido.preco.toStringAsFixed(2) + ' - ' + pedido.descricao,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25
                              ),
                            )
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 10, bottom: 30
                        ),
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(//PRIMEIRO PAGAMENTO
                              padding: EdgeInsets.only(
                                top: 10
                              ),
                              child: Row(
                                children: <Widget>[
                                  Column(//CHECKBOX
                                    children: <Widget>[
                                      Checkbox(
                                        value: pagamentoDinheiro, 
                                        activeColor: Color(0xff2B8309),
                                        onChanged: (bool dim)
                                        {
                                          setState(() {
                                            pagamentoDinheiro = dim;
                                            if(pagamentoDinheiro){
                                              incrementaContador();
                                            }else{
                                              decrementaContador();
                                            }
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'DINHEIRO',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff2B8309),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(//SEGUNDO PAGAMENTO
                              padding: EdgeInsets.only(
                                top: 10
                              ),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Checkbox(
                                        value: pagamentoCartao,
                                        activeColor: Color(0xff2B8309),
                                        onChanged: (bool cart)
                                        {
                                          setState(() {
                                            pagamentoCartao = cart;
                                            if(pagamentoCartao){
                                              incrementaContador();
                                            }else{
                                              decrementaContador();
                                            }
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'CARTÃO',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff2B8309),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: 10
                              ),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Checkbox(
                                        value: pagamentoVR, 
                                        activeColor: Color(0xff2B8309),
                                        onChanged: (bool vr)
                                        {
                                          setState(() {
                                            pagamentoVR = vr;
                                            if(pagamentoVR){
                                              incrementaContador();
                                            }else{
                                              decrementaContador();
                                            }
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'VALE REFEIÇÃO',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff2B8309),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: 40, left: 50
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    contador.toString() + ' meios de pagamento selecionado',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xff2B8309),
                                    ),
                                  )
                                ],
                              )
                            )
                          ],
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 15, left: 265, right: 0, bottom: 20,
            ),
            child: Row(
              children: <Widget>[
                RaisedButton(
                  padding: EdgeInsets.only(
                    top: 10, right: 20, left: 20, bottom: 10,
                  ),
                  child: Text(
                    'Confirmar',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  color: Color(0xff2B8309),
                  textColor: Colors.white,
                  splashColor: Color(0xffA80003),
                  onPressed: (){
                    if(pagamentoDinheiro == false && pagamentoCartao == false && pagamentoVR == false){
                      AlertDialog dialogPagamento = AlertDialog(
                        title: Text(
                          'ATENÇÃO!'
                        ),
                        content: Text(
                          'Selecione uma forma de pagamento!'
                        ),
                      );
                      showDialog(
                        context: context,
                        builder: (context) => dialogPagamento,
                      );
                    }
                    else{
                      Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => FinalPedidoPageState(pedido))
                      );
                      zeraContador();
                    }
                  },
                )
              ],
            ),
          )
        ],
      )
    );
  }

  incrementaContador() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      contador += 1;
      prefs.setInt('contador', contador);
    });
  }

  decrementaContador() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      contador -= 1;
      prefs.setInt('contador', contador);
    });
  }

  zeraContador() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      contador = 0;
      prefs.setInt('contador', contador);
    });
  }
}