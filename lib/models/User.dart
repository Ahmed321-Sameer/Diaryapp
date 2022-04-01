import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? title;
  String? des;
  DateTime? _dateTime;

  UserData({this.title, this.des});

  uploadjson() {
    FirebaseFirestore.instance.collection("blog").add({
      "title": title,
      "description": des,
      "Format_Time": DateTime.now(),
      "time":
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
    }).then((value) {
      print("user has uploaded data");
    });
  }

  updatejson(doc_address) {
    FirebaseFirestore.instance.collection("blog").doc(doc_address).update({
      "title": title,
      "description": des,
      "Format_Time": DateTime.now(),
      "time":
          "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
    }).then((value) {
      print("user has uploaded data");
    });
  }

  // loaddate() {
  //   FirebaseFirestore.instance
  //       .collection("blog")
  //       .snapshots()
  //       .forEach((element) {
  //     element.docs.forEach((element) {
  //       getdata(element);
  //     });
  //   });
  // }

  // getdata(DocumentSnapshot data) {}
}
