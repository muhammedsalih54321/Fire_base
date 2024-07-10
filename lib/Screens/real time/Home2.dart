import 'package:fire_base/Components/Toast%20message.dart';
import 'package:fire_base/Screens/Login.dart';
import 'package:fire_base/Screens/real%20time/Result2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  final auth = FirebaseAuth.instance;
  final post = TextEditingController();
  final database = FirebaseDatabase.instance.ref("Data");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                auth
                    .signOut()
                    .then(
                      (value) => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Loginpage()))
                      },
                    )
                    .onError(
                      (error, stackTrace) => ToastMessage()
                          .toastmessage(message: error.toString()),
                    );
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              controller: post,
              textInputAction: TextInputAction.next,
              maxLines: 8,
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
                  hintStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w300),
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
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.cyan)),
                onPressed: () {
                  final id = DateTime.now().microsecondsSinceEpoch.toString();
                  database
                      .child(id)
                      .set({"id": id, "title": post.text.toString()})
                      .then(
                        (value) => {
                          ToastMessage()
                              .toastmessage(message: 'adding Succesfully'),
                          post.clear()
                        },
                      )
                      .onError(
                        (error, stackTrace) => ToastMessage()
                            .toastmessage(message: error.toString()),
                      );
                },
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.cyan)),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Result2()));
                },
                child: Text(
                  'See Result',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
