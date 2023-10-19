import 'package:flutter/material.dart';
import 'package:otaku_life/Models/UserModel.dart';
import 'package:otaku_life/animeList_page_admin.dart';
import 'package:otaku_life/animeList_page_user.dart';
import 'package:otaku_life/sign_up.dart';
import 'Repository/user_repositpry.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key,});


  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool loading = false;
  bool isError = false;
  bool isSuccess = false;
  String error = "";
  bool showPassword = true;
  final userRepository = UserRepository();
  var formKey = GlobalKey<FormState>();
  var userNamectr = TextEditingController();
  var userPasswordctr = TextEditingController();
  UserModel? user;

  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode1 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
      _focusNode.unfocus();
      _focusNode1.unfocus();

    },
    child: Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
      ),
      body:  FutureBuilder<List<UserModel>>(
        future: UserRepository().getAll(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const Center(
                 );
            }
          else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                  child: Text("Error:${snapshot.error.toString()}"));
            }

            else if (snapshot.hasData) {
              return
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextFormField(
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            validator: (value) {
                              if (value == null) {
                                return "*Value is Null";
                              }

                              if (value.length < 4) {
                                return "User name must be more than 4 !!";
                              }
                              return null;
                            },
                            controller: userNamectr,
                            focusNode: _focusNode,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(

                              labelText: 'Enter user name',
                              labelStyle: const TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red
                                  )),
                              filled: true,
                              fillColor: Colors.grey[200],
                              //prefixIcon: Icon(Icons.theaters),
                            ),
                          ),
                          const SizedBox(height: 16.0),

                          StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState) {
                              return TextFormField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null) {
                                    return "*Value is Null";
                                  }

                                  if (value.length <= 8) {
                                    return "Password should be at least 8 letters";
                                  }
                                  return null;
                                },
                                obscureText: showPassword,
                                controller: userPasswordctr,
                                focusNode: _focusNode1,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  labelText: 'Enter your password',
                                  labelStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  suffixIcon: IconButton(
                                    icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
                                    color: Colors.grey,
                                    onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16.0),

                          if (loading) const CircularProgressIndicator(
                            color: Colors.black,) else ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.black)),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                try {
                                  setState(() {
                                    loading = true;
                                    isSuccess = false;
                                    isError = false;
                                  });

                                  var authenticatedUser = await UserRepository()
                                      .authenticateUser(
                                      userNamectr.text.trim(), userPasswordctr.text);
                                  if (authenticatedUser != null) {
                                    if (userNamectr.text == "Admin" &&
                                        userPasswordctr.text == "Admin1234") {
                                      setState(() {
                                        loading = false;
                                        isSuccess = true;
                                        isError = false;
                                      });
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AnimeListAdmin(
                                                    userId: authenticatedUser.userId ?? 0)));
                                    }
                                    else {
                                      setState(() {
                                        loading = false;
                                        isSuccess = true;
                                        isError = false;
                                      });
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AnimeListUser(
                                                    userId: authenticatedUser.userId ?? 0)));
                                    }
                                  }
                                  else {
                                    setState(() {
                                      loading = false;
                                      isSuccess = false;
                                      isError = true;
                                    });
                                  }
                                }
                                catch (e) {
                                  setState(() {
                                    loading = false;
                                    isSuccess = false;
                                    isError = true;
                                    error = "Exp: ${e.toString()}";
                                  });
                                }
                              }
                            },
                            child: const Text('Log in',
                                style: TextStyle(color: Colors.white)),
                          ),

                          isError ? const Text("Logging in Failed!!",
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center) : const SizedBox(),

                          isSuccess ? const Text("Logged in Successfully",
                              style: TextStyle(color: Colors.green),
                              textAlign: TextAlign.center) : const SizedBox(),

                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()));
                              },
                              child: const Text(
                                  "Don't have an account? Sign up",style: TextStyle(color: Colors.black,
          decoration: TextDecoration.underline,fontStyle: FontStyle.italic,decorationThickness: 2),))
                        ],
                      ),
                    ),
                  ),
                );
            }
            else {
              return Center(
                  child: Text("Error:${snapshot.error.toString()}"));
            }
          }
          else {
            return Center(child: Text("Error:${snapshot.error.toString()}"));
          }
        }
      ),
    ),
    );
  }
}
