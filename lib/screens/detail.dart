import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  DocumentSnapshot doc;
  DateTime time;
  String Month;
  Details({required this.doc, required this.time, required this.Month});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${time.day} $Month ${time.year} ",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(doc.get("description")),
              ],
            ),
          ),
          Positioned(
              bottom: 10,
              left: MediaQuery.of(context).size.width / 2.2,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Done"))),
        ],
      ),
    );
  }
}
