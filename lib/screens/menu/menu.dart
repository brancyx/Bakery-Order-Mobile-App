import 'package:bakeryapp/models/product.dart';
import 'package:bakeryapp/models/user.dart';
import 'package:bakeryapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MenuTab extends StatefulWidget {
  @override
  _MenuTabState createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User user = Provider.of<User>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Menu'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bread_4.jpg"),
              fit: BoxFit.cover,
            )),
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GridView.builder(
                      padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.8),
                    itemCount: breads.length,
                    itemBuilder: (context, index) {
                        double breadCost = breads[index].price;
                      return Card(
                        child: Column(
                          children: <Widget>[
                            Image.asset(breads[index].imgUrl, height: 120, width: 120,),
                            Text(breads[index].title),
                            Text('\$${breadCost.toStringAsFixed(2)}'),
                            Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.remove_circle,color: Colors.red,),
                                onPressed: () {
                                  setState(() {
                                    if (breads[index].qty > 0) {
                                      breads[index].qty -= 1;
                                      totalCost -= breadCost;
                                    }
                                  });
                                },
                              ),
                              Container(
                                width: 40.0,
                                child: Text('${breads[index].qty}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 30.0),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add_circle, color: Colors.green),
                                onPressed: () {
                                  setState(() {
                                    breads[index].qty += 1;
                                    totalCost += breadCost;
                                  });
                                },
                              ),
                            ],
                          ),]
                        ),
                      );
                    }
                ),
                ),
                Container(
                  width: size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Total:',
                          style: TextStyle(fontSize: 30),),
                          SizedBox(width: 170,),
                          Flexible(child: Text('\$ '+ totalCost.toStringAsFixed(2),
                            style: TextStyle(fontSize: 27),
                          ))
                        ],
                      ),
                      SizedBox(height: 10,),
                      RaisedButton(
                        color: Colors.green,
                        onPressed: () async {
                          DateTime now = DateTime.now();
                          String formattedDate = DateFormat('yyyy-MM-dd,  kk:mm').format(now);
                          print(formattedDate);
                          await DatabaseService(uid: user.uid).infoCollection.document(user.uid).updateData(
                              {
                                'orders': FieldValue.arrayUnion([totalCost]),
                                'spending': FieldValue.increment(totalCost),
                                'timestamp': FieldValue.arrayUnion([formattedDate]),
                              }
                          );
                          setState(() {
                          resetEntries();
                        });
                        },
                        child: Text('Submit Order',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

