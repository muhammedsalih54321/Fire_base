import 'package:fire_base/Components/Toast%20message.dart';

import 'package:fire_base/Screens/firestore/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

// import 'package:sms_autofill/sms_autofill.dart';

class Otp extends StatefulWidget {
  final String verificationid;
  const Otp({super.key, required this.verificationid});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  //  @override
  // void initState() {
  //   super.initState();
  //   listenotp();
  // }
  // listenotp()async{
  //   await SmsAutoFill().listenForCode();
  // }

  // @override
  // void dispose() {
  //   SmsAutoFill().unregisterListener();
  //   super.dispose();
  // }
  // String _code="";
  // String signature = "fir-b22de.firebaseapp.com";
FirebaseAuth auth=FirebaseAuth.instance;
final otp=TextEditingController();
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
              SizedBox(height: 55),
              Container(
                width: 380,
                child: TextFormField(
                 controller: otp, 
                ),
              //   child: PinFieldAutoFill(
              //   decoration: UnderlineDecoration(
              //     textStyle: const TextStyle(fontSize: 20, color: Colors.black),
              //     colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
              //   ),
              //   currentCode: _code,
              //   onCodeSubmitted: (code) {},
              //   onCodeChanged: (code) {
              //     if (code!.length == 6) {
              //       FocusScope.of(context).requestFocus(FocusNode());
              //     }
              //   },
              // ),

                // child: OtpTextField(
                  
                //   fieldWidth: 60,
                //   fieldHeight: 60,
                //   numberOfFields: 4,
                //   enabledBorderColor: Colors.black,
                //   borderColor: Colors.black,
                //   showFieldAsBox: true,
                //   onCodeChanged: (String code) {},
                //   onSubmit: (String verificationCode) {
                //     showDialog(
                //         context: context,
                //         builder: (context) {
                //           return AlertDialog(
                //             title: Text("Verification Code"),
                //             content: Text('Code entered is $verificationCode'),
                //           );
                //         });
                //   },
                // ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                ' Didn’t receive a Code?',
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Resend Code!',
                style: GoogleFonts.poppins(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async{
                  final crendital= PhoneAuthProvider.credential(verificationId: widget.verificationid, smsCode: otp.text.toString());
                  try {
                     await auth.signInWithCredential(crendital);
                  } catch (e) {
                   ToastMessage().toastmessage(message: e.toString());
                  }
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Homepage()));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
