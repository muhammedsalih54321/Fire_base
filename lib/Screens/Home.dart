import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base/Components/Toast%20message.dart';
import 'package:fire_base/Screens/Login.dart';
import 'package:fire_base/Screens/Result.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final auth = FirebaseAuth.instance;
  final post = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('Data');
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
                    backgroundColor: WidgetStatePropertyAll(Colors.black)),
                onPressed: () {
                  final id = DateTime.now().microsecondsSinceEpoch.toString();

                  firestore
                      .doc(id)
                      .set({"id": id, "title": post.text.toString()}).then(
                    (value) {
                      ToastMessage().toastmessage(message: 'Post added');
                      post.clear();
                    },
                  ).onError(
                    (error, stackTrace) {
                      ToastMessage().toastmessage(message: error.toString());
                    },
                  );
                },
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                )),
                SizedBox(height: 20,),
                 ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.black)),
                onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>Result()));
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
