class User {

  final String uid;

  // returns only user id
  User({ this.uid });

}

class UserData {

  final String uid;
  final String name;
  final String email;
  final String member;
  final double spending;

  UserData({ this.uid, this.name, this.email, this.member, this.spending });

}

class UserOrders {

  final String uid;
  final List orders;
  final List timestamp;


  UserOrders({this.uid, this.orders, this.timestamp});

}