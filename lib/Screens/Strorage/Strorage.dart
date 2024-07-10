import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base/Components/Toast%20message.dart';
import 'package:fire_base/Screens/Login.dart';
import 'package:fire_base/Screens/Strorage/Result%20page.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Strorage extends StatefulWidget {
  const Strorage({super.key});

  @override
  State<Strorage> createState() => _StrorageState();
}

class _StrorageState extends State<Strorage> {
  final auth = FirebaseAuth.instance;
  File? image;
  final Picker = ImagePicker();
  final firestore = FirebaseFirestore.instance.collection('Files');
  Future<void> getimage() async {
    final PickedFile =
        await Picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (PickedFile != null) {
        image = File(PickedFile.path);
      } else {
        print('Not image');
      }
    });
  }

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                getimage();
                
                
              
              },
              child: Container(
                  height: 200,
                  width: 200,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: image != null
                      ? Image.file(image!.absolute)
                      : Center(
                          child: Icon(
                            Icons.photo,
                            size: 40,
                          ),
                        )),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Color.fromARGB(255, 201, 12, 166))),
              onPressed: () async {
                final id = DateTime.now().microsecondsSinceEpoch.toString();
                firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage.instance
                    .ref('/foldername/' + id);
                firebase_storage.UploadTask uploadTask =
                    ref.putFile(image!.absolute);
                await Future.value(uploadTask).then(
                  (value) async {
                    var newurl = await ref.getDownloadURL();
                    firestore.doc(id).set({"id": id, "title": newurl}).then(
                      (value) => {
                        ToastMessage()
                            .toastmessage(message: 'Uploaded successfully'),
                            setState(() {
                  image=null;
                })
                              
                      },
                    );
                  },
                );
              },
              child: Text(
                'upload',
                style: TextStyle(color: Colors.white),
              )),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                      Color.fromARGB(255, 201, 12, 166))),
              onPressed: () async {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Result_page()));
              },
              child: Text(
                'See result',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
