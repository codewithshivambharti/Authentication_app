import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled2/authentication/Register.dart';
import 'package:untitled2/authentication/forgot_screen.dart';
import 'package:untitled2/authentication/homescreen.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  void loginNow() async {
    setState(() {
      loading = true;
    });
    try {
      await auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void continuewithgoogleNow() async {
    setState(() {
      loading = true;
    });
    String webclient =
        '107132185119-3oqpgb02m90867turshr0sr6u3titf17.apps.googleusercontent.com';
    try {
      GoogleSignIn SignIn = GoogleSignIn.instance;
      await SignIn.initialize(serverClientId: webclient);
      GoogleSignInAccount account = await SignIn.authenticate();
      GoogleSignInAuthentication googleauth = account.authentication;
      final credencial = GoogleAuthProvider.credential(
        idToken: googleauth.idToken,
      );

      await auth.signInWithCredential(credencial);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
        (value) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "LOGIN HERE",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body:
          loading
              ? Center(child: CircularProgressIndicator())
              : Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          label: Text('Email'),
                          hintText: 'Enter Your Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                          label: Text('Password'),
                          hintText: 'Enter Your Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            loginNow();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotScreen(),
                            ),
                          );
                        },
                        child: Text("Forgot Password"),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          continuewithgoogleNow();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Text(
                          "Continue With Google",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),

                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Don't have account?"),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ),
                              );
                            },
                            child: Text(
                              "Register Now",
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
