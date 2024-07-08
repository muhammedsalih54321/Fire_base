import 'package:fire_base/Components/Toast%20message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  FirebaseAuth auth = FirebaseAuth.instance;
    final formKey = GlobalKey<FormState>();
  final forgot = TextEditingController();
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
              Form(
                key: formKey,
                  child: Column(children: [
                SizedBox(height: 55),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
        
                  textInputAction: TextInputAction.next,
                  controller: forgot,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF7F8F9),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      labelText: 'Email adderss',
                      labelStyle: GoogleFonts.poppins(
                        color: Color(0xFF7C7C7C),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      )),
                  validator: (forgot) {
                    if (forgot!.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(forgot)) {
                      return 'Enter a valid email!';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: ()async {
                   if (formKey.currentState!.validate()) {
                     
                      await auth.sendPasswordResetEmail(email: forgot.text.toString()).then((value) => {
                        ToastMessage().toastmessage(message: 'Send your email for  Recover password'),
                            Navigator.pop(context)
                      },).onError((error, stackTrace) => ToastMessage().toastmessage(message: error.toString()),);
                
                   }
                  
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
                            'Verify',
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
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
