import 'package:blog/helpers/dialog.dart';
import 'package:blog/models/providermodel.dart';
import 'package:blog/models/user.dart';
import 'package:blog/screens/detail.dart';
import 'package:blog/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final TextEditingController titlecontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final TextEditingController descontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Provider.of<providermodel>(context, listen: false).Singout();

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => SignUp()));
                },
                icon: Icon(Icons.login_outlined),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("blog")
                  .orderBy("Format_Time", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot curdoc = snapshot.data!.docs[index];
                    DateTime dt = (curdoc['Format_Time'] as Timestamp).toDate();
                    String weekday = "monday";

                    if (dt.weekday == 1) {
                      weekday = "Mon";
                    } else if (dt.weekday == 2) {
                      weekday = "Tue";
                    } else if (dt.weekday == 3) {
                      weekday = "Wed";
                    } else if (dt.weekday == 4) {
                      weekday = "Thur";
                    } else if (dt.weekday == 5) {
                      weekday = "Fri";
                    } else if (dt.weekday == 6) {
                      weekday = "Sat";
                    } else {
                      weekday = "Sun";
                    }
                    return GestureDetector(
                      onTap: () {
                        String monthname = "loading";
                        if (dt.month == 1) {
                          monthname = "January";
                        } else if (dt.month == 2) {
                          monthname = "Feb";
                        } else if (dt.month == 3) {
                          monthname = "March";
                        } else if (dt.month == 4) {
                          monthname = "April";
                        } else if (dt.month == 5) {
                          monthname = "May";
                        } else if (dt.month == 6) {
                          monthname = "June";
                        } else if (dt.month == 7) {
                          monthname = "July";
                        } else if (dt.month == 8) {
                          monthname = "August";
                        } else if (dt.month == 9) {
                          monthname = "September";
                        } else if (dt.month == 10) {
                          monthname = "October";
                        } else if (dt.month == 11) {
                          monthname = "November";
                        } else if (dt.month == 12) {
                          monthname = "December";
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Details(
                                      doc: curdoc,
                                      time: dt,
                                      Month: monthname,
                                    )));
                      },
                      child: Container(
                        child: ListTile(
                          leading: Text("${weekday}\n${dt.day}"),
                          title: Text(curdoc.get("title")),
                          subtitle: Text(curdoc.get("description")),
                          trailing: Container(
                            width: 110,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    dialog(
                                        context,
                                        titlecontroller,
                                        descontroller,
                                        _formkey,
                                        "update",
                                        curdoc.id.toString());
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      curdoc.reference.delete();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          dialog(
              context, titlecontroller, descontroller, _formkey, "new", "none");
        },
        child: const Padding(
          padding: EdgeInsets.all(4),
          child: Text(
            "Add blog",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
