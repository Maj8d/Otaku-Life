import 'package:flutter/material.dart';
import 'package:otaku_life/Repository/user_repositpry.dart';
import 'package:otaku_life/log_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  bool isError = false;
  bool isSuccess = false;
  String error = "";
  bool showPassword = true;
  bool showconfPassword = true;
  var formKey = GlobalKey<FormState>();
  var userNamectr = TextEditingController();
  var userEmailctr = TextEditingController();
  var userPasswordctr = TextEditingController();
  var userConfirmPasswordctr = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _focusNode.unfocus();
          _focusNode1.unfocus();
          _focusNode2.unfocus();
          _focusNode3.unfocus();
        },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value == null) {
                        return "*Value is Null";
                      }

                      if(value.length < 4) {
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
                      errorBorder: const OutlineInputBorder(borderSide: BorderSide(
                          color: Colors.red
                      )),
                      filled: true,
                      fillColor: Colors.grey[200],
                      //prefixIcon: Icon(Icons.theaters),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value == null) {
                        return "*Value is Null";
                      }

                      if(!value.contains('@') || !value.contains(".com") && !value.contains(".net")) {
                        return "This is not an Email !!";
                      }
                      return null;
                    },
                    controller: userEmailctr,
                    focusNode: _focusNode1,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(

                      labelText: 'Enter your email',
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
                      errorBorder: const OutlineInputBorder(borderSide: BorderSide(
                          color: Colors.red
                      )),
                      filled: true,
                      fillColor: Colors.grey[200],
                      //prefixIcon: Icon(Icons.theaters),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value == null) {
                        return "*Value is Null";
                      }

                      if(value.length <= 8 ) {
                        return "Password should be at least 8 litters";
                      }
                      return null;
                    },
                    obscureText: showPassword,
                    controller: userPasswordctr,
                    focusNode: _focusNode2,
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
                      errorBorder: const OutlineInputBorder(borderSide: BorderSide(
                          color: Colors.red
                      )),
                      filled: true,
                      fillColor: Colors.grey[200],
                      suffixIcon:  IconButton(
                        icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),color: Colors.grey,
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value == null) {
                        return "*Value is Null";
                      }

                      if(value != userPasswordctr.text) {
                        return "Confirmation must be similar to the password";
                      }
                      return null;
                    },
                    obscureText: showconfPassword,
                    controller: userConfirmPasswordctr,
                    focusNode: _focusNode3,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(

                      labelText: 'Confirm your password',
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
                      errorBorder: const OutlineInputBorder(borderSide: BorderSide(
                          color: Colors.red
                      )),
                      filled: true,
                      fillColor: Colors.grey[200],
                      suffixIcon:  IconButton(
                        icon: Icon(showconfPassword ? Icons.visibility_off : Icons.visibility),color: Colors.grey,
                        onPressed: () {
                          setState(() {
                            showconfPassword = !showconfPassword;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),


                  loading? const CircularProgressIndicator(color: Colors.black,) : ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                    onPressed: ()async {
                      if(formKey.currentState!.validate())
                      {
                        try{
                          setState(() {
                            loading = true;
                            isSuccess = false;
                            isError = false;
                          });
                          var data = {

                            "userName": userNamectr.text.trim(),
                            "userEmail": userEmailctr.text.trim(),
                            "userPassword": userPasswordctr.text
                          };
                          var registerUser = await UserRepository().add(data);
                          if(registerUser > 0){
                            setState(() {
                              loading = false;
                              isSuccess = true;
                              isError = false;
                            });
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LogIn()));
                          }
                          else{
                            setState(() {
                              loading = false;
                              isSuccess = false;
                              isError = true;
                            });
                          }
                        }
                        catch(e){
                          setState(() {
                            loading = false;
                            isSuccess = false;
                            isError = true;
                            error = "Exp: ${e.toString()}";
                          });
                        }
                      }
                    },
                    child: const Text('Sign up',style: TextStyle(color: Colors.white)),
                  ),

                  isError ? const Text("Registering Failed!!", style: TextStyle(color: Colors.red),textAlign: TextAlign.center) : const SizedBox(),

                  isSuccess ? const Text("Registered Successfully", style: TextStyle(color: Colors.green),textAlign: TextAlign.center) : const SizedBox(),

                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LogIn()));
                      },
                      child: const Text("Already have an account? Log in",style: TextStyle(color: Colors.black,
                          decoration: TextDecoration.underline,fontStyle: FontStyle.italic,decorationThickness: 2),))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
