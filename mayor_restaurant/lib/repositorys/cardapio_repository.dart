import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mayor_restaurant/pedidoItem.dart';

class CardapioRepository {
  CollectionReference collection = Firestore.instance.collection('pedidoItem');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> addPedidoItem(PedidoItem ped){
    return collection.add(ped.toJson());
  }

  removePedidoItem(PedidoItem ped) async{
    await collection.document(ped.reference.documentID).delete();
  }
}