import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Result_page extends StatefulWidget {
  const Result_page({super.key});

  @override
  State<Result_page> createState() => _Result_pageState();
}

class _Result_pageState extends State<Result_page> {
  final firestore = FirebaseFirestore.instance.collection('Files').snapshots();
  @override
  Widget build(BuildContext context) {
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
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      padding: EdgeInsets.all(8.0),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.blue,
                          child: Image.network(
                            snapshot.data!.docs[index]["title"].toString(),
                            fit: BoxFit.cover,
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
