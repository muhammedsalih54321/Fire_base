import 'package:fire_base/Components/Toast%20message.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Result2 extends StatefulWidget {
  const Result2({super.key});

  @override
  State<Result2> createState() => _Result2State();
}

class _Result2State extends State<Result2> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref("Data");

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
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
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;

                      print("hi" + map.values.toString());
                      return ListView.builder(
                        itemCount: snapshot.data!.snapshot.children.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                map.values.toList()[index]["title"].toString()),
                            trailing: Wrap(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      opendailoge(
                                          index: index,
                                          id: map.values
                                              .toList()[index]["id"]
                                              .toString(),
                                          snapshot: snapshot);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      ref
                                          .child(map.values
                                              .toList()[index]["id"]
                                              .toString())
                                          .remove();
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
                  }))
        ],
      )),
    );
  }

  Future opendailoge(
      {required int index,
      required String id,
      required AsyncSnapshot<DatabaseEvent> snapshot}) async {
    final editpost = TextEditingController();

    final ref = FirebaseDatabase.instance.ref("Data");
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
                ref
                    .child(id)
                    .update({'title': editpost.text.toString()})
                    .then(
                      (value) => {
                        ToastMessage()
                            .toastmessage(message: 'Edited Succesfull'),
                        editpost.clear(),
                        Navigator.pop(context),
                      },
                    )
                    .onError(
                      (error, stackTrace) => ToastMessage()
                          .toastmessage(message: error.toString()),
                    );
              },
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
