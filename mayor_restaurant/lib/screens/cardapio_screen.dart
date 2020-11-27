
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mayor_restaurant/pedidoItem.dart';
import 'package:mayor_restaurant/repositorys/cardapio_repository.dart';
import 'package:mayor_restaurant/screens/pagamentoPedido_screen.dart';

class CardapioPageState extends StatefulWidget {

  String nomePrato;
  double precoPrato;
  String descricaoPrato;

  @override
  CardapioScreen createState() => new CardapioScreen();
}

class CardapioScreen extends State<CardapioPageState> {

  final CardapioRepository repository = CardapioRepository();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cardápio"
        ),
        backgroundColor: Color(0xff2B8309),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getStream(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return LinearProgressIndicator(
              backgroundColor: Color(0xffA80003),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff2B8309)),
            );
          }
          return _buildList(context, snapshot.data.documents);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (_) => SimpleDialog(
              title: Text(
                "Cadastro de prato,preço e descrição:",
                style: TextStyle(
                  color: Color(0xff2B8309),
                ),
              ),
              children: [
                SimpleDialogOption(
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA80003))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff2B8309))),
                      hintText: 'Nome do prato',
                      hintStyle: TextStyle(color: Color(0xff2B8309))
                    ),
                    onChanged: (prato) => widget.nomePrato = prato,
                  ),
                ),
                SimpleDialogOption(
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA80003))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff2B8309))),
                      hintText: 'Preço do prato',
                      hintStyle: TextStyle(color: Color(0xff2B8309))
                    ),
                    onChanged: (preco) => widget.precoPrato = double.parse(preco),
                  ),
                ),
                SimpleDialogOption(
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffA80003))),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff2B8309))),
                      hintText: 'Descrição do prato',
                      hintStyle: TextStyle(color: Color(0xff2B8309))
                    ),
                    onChanged: (descricao) => widget.descricaoPrato = descricao,
                  ),
                ),
                SimpleDialogOption(
                  child: RaisedButton(
                    padding: EdgeInsets.only(
                      top:20, left: 20, right: 20, bottom: 20,
                    ),
                    child: Text('Inserir item'),
                    color: Color(0xff2B8309),
                    textColor: Colors.white,
                    splashColor: Color(0xffA80003),
                    onPressed: (){
                      PedidoItem newPedidoItem = PedidoItem(prato: widget.nomePrato,preco: widget.precoPrato,descricao: widget.descricaoPrato);
                      repository.addPedidoItem(newPedidoItem);
                      Navigator.of(context).pop();
                    }
                  ),
                )
              ],
            )
          );
        }, 
        child: Icon(
          Icons.add
        ),
        backgroundColor: Color(0xff2B8309),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    ); 
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final ped = PedidoItem.fromSnapshot(snapshot);
    if(ped == null){
      return Container();
    }

    return Container(
      padding: EdgeInsets.only(
        top: 10, bottom: 10, left: 10, right: 10
      ),
      child: InkWell(
        child: Column(
          children: [
            ListTile(
              leading: ButtonTheme(
                minWidth: 25.0,
                height: 25.0,
                buttonColor: Color(0xffA80003),
                child: RaisedButton(
                  child: Icon(
                    Icons.remove_circle_outline,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    removerItem(ped);
                  }
                ),
              ),
              title: Text(
                ped.prato,
                style: TextStyle(
                  fontSize: 17
                ),
              ),
              trailing: Text(
                'R\$ ' + ped.preco.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 17
                ),
              ),
            )
          ],
        ),
        onTap: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => PagamentoPageState(ped))
          );
        },
      )
    );
  }

  void removerItem(PedidoItem ped){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text(
            'Remover item do cardápio',
            style: TextStyle(
              color:Color(0xff2B8309),
              fontSize: 20
            ),
          ),
          content: Text(
            'Tem certeza que deseja remover o item?',
            style: TextStyle(
              color:Color(0xff2B8309),
              fontSize: 15
            ),
          ),
          actions: [
            RaisedButton(
              child: Text('Cancelar'),
              onPressed: (){
                Navigator.of(context).pop();
              }
            ),
            RaisedButton(
              child: Text('Remover'),
              color: Color(0xffA80003),
              onPressed: (){
                Navigator.of(context).pop();
                repository.removePedidoItem(ped);
              }
            ),
          ],
        );
      }
    );
  }
}