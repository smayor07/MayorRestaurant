import 'package:mayor_restaurant/pedidoItem.dart';
import 'package:flutter/material.dart';

class FinalPedidoPageState extends StatefulWidget {

  final PedidoItem ped;

  FinalPedidoPageState(this.ped);

  @override
  FinalPedidoScreen createState() => new FinalPedidoScreen(this.ped);
}

class FinalPedidoScreen extends State<FinalPedidoPageState>{
  
  PedidoItem pedido;

  FinalPedidoScreen(this.pedido);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido Finalizado",
        ),
        backgroundColor: Color(0xff2B8309),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 20, bottom: 10, left: 45, right: 10
            ),
            child: Expanded(
              child: Column(
                children: [
                  Text(
                    'Pedido realizado!',
                    style: TextStyle(
                      fontSize: 30,
                      color: Color(0xff2B8309),
                    ),
                  ),
                  Card(
                    color: Color(0xff2B8309),
                    child: Column(
                      children: [
                        Text(
                          pedido.prato + ' - R\$ ' + pedido.preco.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white
                          ),
                        ),
                        Text(
                          'Detalhes: ' + pedido.descricao,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 50, bottom: 10, left: 10
                    ),
                    child: Image.asset(
                      'imagens/Concluido.png',
                      height: 270,
                    ),
                  ),
                  RaisedButton(
                    padding: EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 10
                    ),
                    color: Color(0xff2B8309),
                    child: Text(
                      'Retornar a tela de cardápio',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    }
                  )
                ],
              )
            )
          )
        ],
      )
    );
  }
}