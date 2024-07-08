import 'package:fire_base/Components/Toast%20message.dart';
import 'package:fire_base/Screens/Otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final phone = TextEditingController();
  FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                  child: AppBar(
                backgroundColor: Colors.white,
              )),
              SizedBox(
                height: 120,
              ),
              Form(
                  child: Column(children: [
                SizedBox(height: 55),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  
                  keyboardType: TextInputType.datetime,
                  maxLength: 10,
                  textInputAction: TextInputAction.next,
                  controller: phone,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefix: Text('+91 '),
                      filled: true,
                      fillColor: Color(0xFFF7F8F9),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      labelText: 'Phone number',
                      labelStyle: GoogleFonts.poppins(
                        color: Color(0xFF7C7C7C),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      )),
                  // validator: (email) {
                  //   if (email!.isEmpty ||
                  //       !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  //           .hasMatch(email)) {
                  //     return 'Enter a valid email!';
                  //   }
                  //   return null;
                  // },
                ),

                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    auth.verifyPhoneNumber(
                      phoneNumber: "+91${phone.text.toString()}",
                      verificationCompleted:(_) {
                      
                    },
                     verificationFailed:(error) {
                       ToastMessage().toastmessage(message: error.toString());
                     },
                      codeSent: (String verificationId,int?token)async {
                          // final signature = await SmsAutoFill().getAppSignature;
                          Navigator.push(context,MaterialPageRoute(builder: (_)=>Otp(verificationid:verificationId,)));
                      },
                       codeAutoRetrievalTimeout: (error) {
                          ToastMessage().toastmessage(message:error.toString());
                       },);    
                  
                  },
                  child: Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Send code',
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 0.10),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),

                SizedBox(
                  height: 160,
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Don’t have an account?',
                //       style: GoogleFonts.inter(
                //           color: Colors.black,
                //           fontSize: 14,
                //           fontWeight: FontWeight.w500,
                //           height: 0.10),
                //     ),
                //     TextButton(
                //       onPressed: () {
                //         Navigator.push(
                //             context, MaterialPageRoute(builder: (_) => SignUp()));
                //       },
                //       child: Text(
                //         ' Sign up Now',
                //         style: GoogleFonts.inter(
                //             color: Colors.blue,
                //             fontSize: 14,
                //             fontWeight: FontWeight.w500,
                //             height: 0.10),
                //       ),
                //     )
                //   ],
                // ),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
