import 'package:bakeryapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference infoCollection = Firestore.instance.collection('info');

  Future<void> updateUserData(String name, String email, String member, double spending, List orders, List time) async {
    return await infoCollection.document(uid).setData({
      'name': name,
      'email': email,
      'member': member,
      'spending': spending,
      'orders': orders,
      'timestamp': time,
    });
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        email: snapshot.data['email'],
        member: snapshot.data['member'],
      spending: snapshot.data['spending'],
    );
  }

  UserOrders _userOrdersFromSnapshot(DocumentSnapshot snapshot) {
    return UserOrders(
      uid: uid,
      orders: snapshot.data['orders'],
      timestamp: snapshot.data['timestamp']
,    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return infoCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  Stream<UserOrders> get userOrders {
    return infoCollection.document(uid).snapshots().map(_userOrdersFromSnapshot);
  }

}