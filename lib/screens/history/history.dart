import 'package:bakeryapp/models/user.dart';
import 'package:bakeryapp/services/database.dart';
import 'package:bakeryapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryTab extends StatefulWidget {
  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User user = Provider.of<User>(context);

    return StreamBuilder<UserOrders>(
      stream: DatabaseService(uid: user.uid).userOrders,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List orders = snapshot.data.orders ?? [];
          List timeDate = snapshot.data.timestamp;
          int orderCount = orders.length;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text('Orders'),
            backgroundColor: Colors.transparent,
            centerTitle: true,
          ),
          body: Container(
            width: size.width,
            height: size.height,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/products_tab.jpg"),
                  fit: BoxFit.cover,
                )),
            child: ListView.builder(
              itemCount: orderCount,
              itemBuilder: (context, index) {
                double amtSpent = orders[index];
                return Card(
                  child: ListTile(
                    title: Text('Order ${index+1}'),
                    subtitle: Text(timeDate[index] + ' H'),
                    trailing: Text('Amount: \$ ${amtSpent.toStringAsFixed(2)}'),
                  ),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: Text('CLEAR', style: TextStyle(color: Colors.white, fontSize: 13),),
            backgroundColor: Colors.red,
            elevation: 20,
            onPressed: () async{
              await DatabaseService(uid: user.uid).infoCollection.document(user.uid).updateData({
                'orders': [],
                'timestamp': [],
                'spending': 0.00,
              });
            },
          ),
        );}
        else {return Loading();}
      }
    );
  }
}
