import 'package:cloud_firestore/cloud_firestore.dart';

class PedidoItem {
  String prato;
  double preco;
  String descricao;

  DocumentReference reference;

  PedidoItem({this.prato,this.preco,this.descricao});

  factory PedidoItem.fromSnapshot(DocumentSnapshot snapshot) {
    PedidoItem newPedidoItem = PedidoItem.fromJson(snapshot.data);
    newPedidoItem.reference = snapshot.reference;
    return newPedidoItem;
  }

  factory PedidoItem.fromJson(Map<dynamic, dynamic> json) => _PedidoItemFromJson(json);

  Map<String, dynamic> toJson() => _PedidoItemToJson(this);
}

PedidoItem _PedidoItemFromJson(Map<dynamic, dynamic> json) {
  return PedidoItem(
    prato: json['prato'] as String,
    preco: json['preco'] as double,
    descricao: json['descricao'] as String
  );
}

Map<String, dynamic> _PedidoItemToJson(PedidoItem instance) => <String, dynamic> {
  'prato':instance.prato,
  'preco':instance.preco,
  'descricao':instance.descricao
};
