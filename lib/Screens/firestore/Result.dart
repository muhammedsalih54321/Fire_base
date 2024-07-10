import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base/Components/Toast%20message.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final editpost = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('Data').snapshots();
  final ref =FirebaseFirestore.instance.collection('Data');
  @override
  Widget build(BuildContext context) {
    Future opendailoge({required int index,
    required String id,
    required AsyncSnapshot<QuerySnapshot> snapshot}) async {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Edit Here'),
          content: TextFormField(
            controller: editpost,
            textInputAction: TextInputAction.next,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                filled: true,
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                fillColor: Color(0xFFF7F8F9),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8)),
                hintText: 'Type here',
                hintStyle:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
                labelStyle: GoogleFonts.poppins(
                  color: Color(0xFF7C7C7C),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 0.10,
                )),
            validator: (email) {
              if (email!.isEmpty) {
                return 'Enter something';
              }
              return null;
            },
          ),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black)),
                onPressed: () {
                 ref.doc(snapshot.data!.docs[index]["id"].toString()).update({"title":editpost.text.toString()}).then((value) => {
                  ToastMessage().toastmessage(message: 'Edited Succesfull'),
                   editpost.clear(),

                  Navigator.pop(context),
                 
                 },).onError((error, stackTrace) => ToastMessage().toastmessage(message: error.toString()),);
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: firestore,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('error'),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              snapshot.data!.docs[index]['title'].toString()),
                          trailing: Wrap(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    opendailoge(index: index, id: snapshot.data!.docs[index].id.toString(), snapshot: snapshot);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    ref.doc(snapshot.data!.docs[index]["id"].toString()).delete();
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return SizedBox();
                  }
                }),
          )
        ],
      )),
    );
  }
}
