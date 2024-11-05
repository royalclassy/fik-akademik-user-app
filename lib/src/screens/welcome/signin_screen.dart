// // import 'package:class_leap/src/features/authentication/screens/signup_screen.dart';
// // import 'package:class_leap/src/user/firebase_auth_services.dart';
// // import 'package:class_leap/src/utils/theme/theme.dart';
// // import 'package:flutter/material.dart';
// // import 'package:class_leap/src/utils/widgets/custom_scaffold.dart';
// // import 'package:flutter/rendering.dart';
// // import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
// // import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
// // import 'package:class_leap/src/features/authentication/screens/profile_page.dart';
// //
// //
// // class SignInScreen extends StatefulWidget {
// //   const SignInScreen({super.key});
// //
// //   @override
// //   State<SignInScreen> createState() => _SignInScreenState();
// // }
// //
// // class _SignInScreenState extends State<SignInScreen> {
// //   final FirebaseAuthService _auth = FirebaseAuthService();
// //
// //   TextEditingController _emailController = TextEditingController();
// //   TextEditingController _passwordController = TextEditingController();
// //
// //   final _formSignInKey = GlobalKey<FormState>();
// //   bool rememberPassword = true;
// //   @override
// //   void dispose() {
// //     // TODO: implement dispose
// //     _emailController.dispose();
// //     _passwordController.dispose();
// //     super.dispose();
// //   }
// //   Widget build(BuildContext context) {
// //     return CustomScaffold(
// //       child: Column(
// //         children: [
// //           const Expanded(
// //             flex: 1,
// //             child: SizedBox(
// //               height: 10,
// //             ),
// //           ),
// //           Expanded(
// //             flex: 7,
// //             child: Container(
// //               padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
// //               decoration: const BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.only(
// //                   topLeft: Radius.circular(40),
// //                   topRight: Radius.circular(40),
// //                 ),
// //               ),
// //
// //               child: SingleChildScrollView(
// //                 child: Form(
// //                   key: _formSignInKey,
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       Text(
// //                         'Welcome back',
// //                         style: TextStyle(
// //                           fontSize: 30.0,
// //                           fontWeight: FontWeight.w900,
// //                           color: lightColorScheme.primary,
// //                         ),
// //                       ),
// //                       const SizedBox(
// //                         height: 20,
// //                       ),
// //                       TextFormField(
// //                         controller: _emailController,
// //                         validator: (value) {
// //                           if (value == null || value.isEmpty) {
// //                             return 'Please enter your email';
// //                           }
// //                           return null;
// //                         },
// //                         decoration: InputDecoration(
// //                           label: const Text('Email'),
// //                           hintText: 'Enter your email',
// //                           hintStyle: const TextStyle(
// //                             color: Colors.black26,
// //                           ),
// //                           border: OutlineInputBorder(
// //                             borderSide: const BorderSide(
// //                               color: Colors.black12,
// //                             ),
// //                             borderRadius: BorderRadius.circular(10),
// //                           ),
// //                           enabledBorder: OutlineInputBorder(
// //                             borderSide: const BorderSide(
// //                               color: Colors.black12,
// //                             ),
// //                             borderRadius: BorderRadius.circular(10),
// //                           ),
// //                         ),
// //                       ),
// //                       const SizedBox(
// //                         height: 20,
// //                       ),
// //                       TextFormField(
// //                         controller: _passwordController,
// //                         obscureText: true,
// //                         obscuringCharacter: '*',
// //                         validator: (value) {
// //                           if (value == null || value.isEmpty) {
// //                             return 'Please enter your password';
// //                           }
// //                           return null;
// //                         },
// //                         decoration: InputDecoration(
// //                           label: const Text('Password'),
// //                           hintText: 'Enter your password',
// //                           hintStyle: const TextStyle(
// //                             color: Colors.black26,
// //                           ),
// //                           border: OutlineInputBorder(
// //                             borderSide: const BorderSide(
// //                               color: Colors.black12,
// //                             ),
// //                             borderRadius: BorderRadius.circular(10),
// //                           ),
// //                           enabledBorder: OutlineInputBorder(
// //                             borderSide: const BorderSide(
// //                               color: Colors.black12,
// //                             ),
// //                             borderRadius: BorderRadius.circular(10),
// //                           ),
// //                         ),
// //                       ),
// //                       const SizedBox(
// //                         height: 20,
// //                       ),
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Row(
// //                             children: [
// //                               Checkbox(
// //                                 value: rememberPassword,
// //                                 onChanged: (bool? value) {
// //                                   setState(() {
// //                                     rememberPassword = value!;
// //                                   });
// //                                 },
// //                                 activeColor: lightColorScheme.primary,
// //                               ),
// //                               const Text(
// //                                 'Remember me',
// //                                 style: TextStyle(color: Colors.black45),
// //                               ),
// //                             ],
// //                           ),
// //                           GestureDetector(
// //                             child: Text(
// //                               'Forgot password?',
// //                               style: TextStyle(
// //                                 fontWeight: FontWeight.bold,
// //                                 color: lightColorScheme.primary,
// //                               ),
// //                             ),
// //                           )
// //                         ],
// //                       ),
// //                       const SizedBox(
// //                         height: 20,
// //                       ),
// //                       SizedBox(
// //                         width: double.infinity,
// //
// //                         child: ElevatedButton(
// //                             style: ButtonStyle(
// //                               backgroundColor: MaterialStateProperty.all<Color>(
// //                                   lightColorScheme.primary),),
// //                             onPressed: () {
// //                               if (_formSignInKey.currentState!.validate() &&
// //                                   rememberPassword) {
// //                                 Navigator.pushNamed(context, '/profile');
// //                               } else if (!rememberPassword) {
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   const SnackBar(
// //                                     content: Text(
// //                                         'Please agree to the processing of your data'),
// //                                   ),
// //                                 );
// //                               }
// //                               else if (!rememberPassword) {
// //                                 ScaffoldMessenger.of(context).showSnackBar(
// //                                   const SnackBar(
// //                                     content: Text(
// //                                         'Please agree to the processing of your data'),
// //                                   ),
// //                                 );
// //                               }
// //                             },
// //                             child: const Text('Sign in')),
// //                       ),
// //                       const SizedBox(
// //                         height: 20,
// //                       ),
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Expanded(child: Divider(
// //                             thickness: 0.7,
// //                             color: Colors.grey.withOpacity(0.5),
// //                           ),),
// //                           const Padding(
// //                             padding: EdgeInsets.symmetric(
// //                                 vertical: 0,
// //                                 horizontal: 10),
// //                             child: Text('Sign up with',
// //                               style: TextStyle(
// //                                 color: Colors.black45,
// //                               ),
// //                             ),
// //                           ),
// //                           Expanded(child: Divider(
// //                             thickness: 0.7,
// //                             color: Colors.grey.withOpacity(0.5),
// //                           ),),
// //                         ],
// //                       ),
// //                       const SizedBox(
// //                         height: 20,
// //                       ),
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                         children: [
// //                           IconButton(
// //                             onPressed: () {},
// //                             icon: const Icon(
// //                               Icons.facebook,
// //                               color: Colors.blue,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(
// //                         height: 20,
// //                       ),
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           const Text(
// //                             'Don\'t have an account?',
// //                             style: TextStyle(
// //                               color: Colors.black45,
// //                             ),
// //                           ),
// //                           GestureDetector(
// //                             onTap: () {
// //                               Navigator.push(context, MaterialPageRoute(
// //                                   builder: (e) => const SignUpScreen()));
// //                             },
// //                             child: Text(
// //                               'Sign up',
// //                               style: TextStyle(
// //                                 color: lightColorScheme.primary,
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //   void _signIn() async {
// //     String email = _emailController.text;
// //     String password = _passwordController.text;
// //
// //     try {
// //       UserCredential userCredential = await FirebaseAuth.instance
// //           .signInWithEmailAndPassword(
// //         email: email,
// //         password: password,
// //       );
// //
// //       User? user = userCredential.user;
// //
// //       if (user != null) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text('Sign in success'),
// //           ),
// //         );
// //         Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => const ProfilePage(),
// //           ),
// //         );
// //       } else {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text('Sign in failed'),
// //           ),
// //         );
// //       }
// //     } on FirebaseAuthException catch (e) {
// //       print('FirebaseAuthException: ${e.code}, ${e.message}');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Error: ${e.message}'),
// //         ),
// //       );
// //     } catch (e) {
// //       print('Error: $e');
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text('Error: $e'),
// //         ),
// //       );
// //     }
// //   }
//
// import 'package:class_leap/src/screens/welcome/signup_screen.dart';
// import 'package:class_leap/src/user/firebase_auth_services.dart';
// import 'package:class_leap/src/utils/theme/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:class_leap/src/utils/widgets/custom_scaffold.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
// import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
// import 'package:class_leap/src/screens/profile_page.dart'; // Import ProfilePage
//
// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});
//
//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   final FirebaseAuthService _auth = FirebaseAuthService();
//
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//
//   final _formSignInKey = GlobalKey<FormState>();
//   bool rememberPassword = true;
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       child: Column(
//         children: [
//           const Expanded(
//             flex: 1,
//             child: SizedBox(
//               height: 10,
//             ),
//           ),
//           Expanded(
//             flex: 7,
//             child: Container(
//               padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formSignInKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Selamat datang kembali',
//                         style: TextStyle(
//                           fontSize: 30.0,
//                           fontWeight: FontWeight.w900,
//                           color: lightColorScheme.primary,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                         controller: _emailController,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Masukkan email anda';
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           label: const Text('Email'),
//                           hintText: 'Masukkan email anda',
//                           hintStyle: const TextStyle(
//                             color: Colors.black26,
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.black12,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.black12,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       TextFormField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         obscuringCharacter: '*',
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Masukkan kata sandi anda';
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           label: const Text('Password'),
//                           hintText: 'Masukkan kata sandi anda',
//                           hintStyle: const TextStyle(
//                             color: Colors.black26,
//                           ),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.black12,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Colors.black12,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: rememberPassword,
//                                 onChanged: (bool? value) {
//                                   setState(() {
//                                     rememberPassword = value!;
//                                   });
//                                 },
//                                 activeColor: lightColorScheme.primary,
//                               ),
//                               const Text(
//                                 'Ingat saya',
//                                 style: TextStyle(color: Colors.black45),
//                               ),
//                             ],
//                           ),
//                           GestureDetector(
//                             child: Text(
//                               'Lupa kata sandi?',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: lightColorScheme.primary,
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 lightColorScheme.primary),
//                           ),
//                           onPressed: () {
//                             if (_formSignInKey.currentState!.validate() &&
//                                 rememberPassword) {
//                               _signIn();
//                             } else if (!rememberPassword) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text(
//                                       'Tolong setujui pemrosesan data anda'),
//                                 ),
//                               );
//                             }
//                           },
//                           child: const Text('Masuk'),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Expanded(
//                             child: Divider(
//                               thickness: 0.7,
//                               color: Colors.grey.withOpacity(0.5),
//                             ),
//                           ),
//                           const Padding(
//                             padding: EdgeInsets.symmetric(
//                                 vertical: 0, horizontal: 10),
//                             child: Text(
//                               'Belum punya akun?',
//                               style: TextStyle(
//                                 color: Colors.black45,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Divider(
//                               thickness: 0.7,
//                               color: Colors.grey.withOpacity(0.5),
//                             ),
//                           ),
//                         ],
//                       ),
//                       // const SizedBox(
//                       //   height: 20,
//                       // ),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       //   children: [
//                       //     IconButton(
//                       //       onPressed: () {},
//                       //       icon: const Icon(
//                       //         Icons.facebook,
//                       //         color: Colors.blue,
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       // const SizedBox(
//                       //   height: 20,
//                       // ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Text(
//                             'Belum punya akun? ',
//                             style: TextStyle(
//                               color: Colors.black45,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (e) => const SignUpScreen()),
//                               );
//                             },
//                             child: Text(
//                               'Daftar',
//                               style: TextStyle(
//                                 color: lightColorScheme.primary,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _signIn() async {
//     String email = _emailController.text;
//     String password = _passwordController.text;
//
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       User? user = userCredential.user;
//
//       if (user != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Sign in success'),
//           ),
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const ProfilePage(),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Sign in failed'),
//           ),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       print('FirebaseAuthException: ${e.code}, ${e.message}');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: ${e.message}'),
//         ),
//       );
//     } catch (e) {
//       print('Error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: $e'),
//         ),
//       );
//     }
//   }
// }

import 'package:class_leap/src/screens/jadwal/jadwal_screen.dart';
import 'package:class_leap/src/screens/welcome/signup_screen.dart';
import 'package:class_leap/src/user/firebase_auth_services.dart';
import 'package:class_leap/src/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:class_leap/src/utils/widgets/custom_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:class_leap/src/screens/profile/profile_page.dart'; // Import ProfilePage
import 'package:class_leap/src/utils/data/api_data.dart';
import 'package:class_leap/main.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formSignInKey.currentState!.validate()) {
      // Debug prints to check the values

      int statusCode = await login(_emailController.text, _passwordController.text);
      if (statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login success')),
        );
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(
            flex: 1,
            child: SizedBox(
              height: 10,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Selamat datang kembali',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: lightColorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan email anda';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Email'),
                          hintText: 'Masukkan email anda',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan kata sandi anda';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text('Kata Sandi'),
                          hintText: 'Masukkan kata sandi anda',
                          hintStyle: const TextStyle(
                            color: Colors.black26,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberPassword,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberPassword = value!;
                                  });
                                },
                                activeColor: lightColorScheme.primary,
                              ),
                              const Text(
                                'Ingat saya',
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                          GestureDetector(
                            child: Text(
                              'Lupa kata sandi?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: lightColorScheme.primary,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                lightColorScheme.primary),
                          ),
                          onPressed: () {
                            // if (_formSignInKey.currentState!.validate() &&
                            //     rememberPassword) {
                            //   _signIn();
                            // } else if (!rememberPassword) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text(
                            //           'Tolong setujui pemrosesan data anda'),
                            //     ),
                            //   );
                            // }
                            _handleLogin();
                          },
                          child: Text(
                            'Masuk',
                            style: TextStyle(
                              color: lightColorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            child: Text(
                              'Belum punya akun?',
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (e) => const SignUpScreen()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0), // Add padding to the right
                              child: Text(
                                'Daftar',
                                style: TextStyle(
                                  color: lightColorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.7,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign in success'),
          ),
        );
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign in failed'),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code}, ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
        ),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }}