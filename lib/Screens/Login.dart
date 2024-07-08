import 'package:fire_base/Components/Toast%20message.dart';
import 'package:fire_base/Screens/Forgot%20password.dart';
import 'package:fire_base/Screens/Home.dart';
import 'package:fire_base/Screens/Phone.dart';
import 'package:fire_base/Screens/Sign%20up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool loading = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final email = TextEditingController();
  final password = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  var isobscure;
  final formKey = GlobalKey<FormState>();
  

  @override
  void initState() {
    isobscure = true;
    super.initState();
  }
  Future<void>signinwithgoogle()async{
    try {
      final GoogleSignInAccount? googleSignInAccount= await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication= await googleSignInAccount!.authentication;

      final AuthCredential credential=GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );

      final UserCredential userCredential= await auth.signInWithCredential(credential);
      final User? user= userCredential.user;
      if (user!=null) {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>Homepage()));
        ToastMessage().toastmessage(message: 'succusfully completed');
      }
    } catch (e) {
      ToastMessage().toastmessage(message: e.toString());
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 50,
          ),
          Form(
              key: formKey,
              child: Column(children: [
                SizedBox(height: 55),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: email,
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
                      labelText: 'email address',
                      labelStyle: GoogleFonts.poppins(
                        color: Color(0xFF7C7C7C),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      )),
                  validator: (email) {
                    if (email!.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email)) {
                      return 'Enter a valid email!';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: password,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF7F8F9),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      labelText: 'Enter password  ',
                      labelStyle: GoogleFonts.poppins(
                        color: Color(0xFF7C7C7C),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isobscure = !isobscure;
                            });
                          },
                          icon: isobscure
                              ? Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.black,
                                  size: 20,
                                )
                              : Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ))),
                  obscureText: isobscure,
                  validator: (password) {
                    if (password!.isEmpty || password.length < 6) {
                      return 'Enter a valid password!';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Forgotpassword()));
                        },
                        child: Text(
                          'forget password',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF7C7C7C),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 0.12,
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                GestureDetector(
                  onTap: () async {
                 if (formKey.currentState!.validate()) {
                   
                      setState(() {
                              loading = true;
                            });
                    await auth
                        .signInWithEmailAndPassword(
                            email: email.text.toString(),
                            password: password.text.toString())
                        .then(
                          (value) => {
                           
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Homepage())),
                                 setState(() {
                              loading = false;
                            }),
                          },
                          
                        )
                        .onError(
                          (error, stackTrace) => ToastMessage()
                              .toastmessage(message: error.toString()),
                        );
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
                          loading
                              ? CircularProgressIndicator()
                              : Text(
                                  'Login',
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
                Text(
                  'Or Login With',
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 0.10),
                ),
                SizedBox(height: 40),
                Container(
                  height: 56,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          signinwithgoogle();
                        },
                        child: Container(
                          width: 105,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Image.asset(
                              'assets/images/google.png',
                              height: 28,
                              width: 28,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                   onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Phone())),
                        child: Container(
                          width: 105,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Image.asset(
                              'assets/images/phone.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 160,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account?',
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 0.10),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignUp()));
                      },
                      child: Text(
                        ' Sign up Now',
                        style: GoogleFonts.inter(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 0.10),
                      ),
                    )
                  ],
                ),
              ]))
        ]),
      ),
    ));
  }
}
