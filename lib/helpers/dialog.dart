import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blog/models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

dialog(context, TextEditingController titlecontroller,
    TextEditingController descontroller, _formkey, type, doc_address) {
  AwesomeDialog(
    customHeader: Container(
      height: 120,
      width: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage("assets/gif.gif"), fit: BoxFit.fill)),
    ),
    context: context,
    dialogType: DialogType.INFO,
    animType: AnimType.BOTTOMSLIDE,
    body: Form(
      key: _formkey,
      child: Column(
        children: [
          Text("Enter Details"),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return "must enter title";
              }
            }),
            controller: titlecontroller,
            decoration: InputDecoration(hintText: "title"),
          ),
          TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return "must enter description";
              }
            }),
            controller: descontroller,
            decoration: InputDecoration(hintText: "description"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      if (type == "new") {
                        UserData data = UserData(
                            title: titlecontroller.text.toString().trim(),
                            des: descontroller.text.toString().trim());
                        data.uploadjson();
                      } else {
                        UserData data = UserData(
                            title: titlecontroller.text.toString().trim(),
                            des: descontroller.text.toString().trim());
                        data.updatejson(doc_address);
                      }

                      titlecontroller.clear();
                      descontroller.clear();
                      Navigator.pop(context);
                    } else {
                      print("fields not satisfied");
                    }
                  },
                  child: Text(type == "new" ? "Upload" : "update")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
            ],
          )
        ],
      ),
    ),
  )..show();
}
