import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otaku_life/Models/UserModel.dart';
import 'package:otaku_life/Repository/user_repositpry.dart';
import 'package:otaku_life/animeList_page_all_users.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.userId}) : super(key: key);
  final int userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loading = false;
  bool isError = false;
  bool isSuccess = false;
  String error = "";
  var formKey = GlobalKey<FormState>();
  var formKey2 = GlobalKey<FormState>();

  var userNamectr = TextEditingController();
  var userEmailctr = TextEditingController();
  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to logout?',textAlign: TextAlign.center),
          actions: [
            TextButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
              onPressed: () {
                // Perform the desired action when "Cancel" is pressed
                Navigator.of(context).pop(false);
              },
              child: const Text('No',style: TextStyle(color: Colors.white)),
            ),
            TextButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const AnimeList()));
              },
              child: const Text('Yes',style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  String? _imagePath;
  File? _image;
  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _imagePath = pickedImage.path; // Store the image path
      });
    }
  }

  UserModel? userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        actions: [
          GestureDetector(
            onTap: () {
              showConfirmationDialog(context);
            },
            child: const IconButton(
              icon: Icon(Icons.logout,color: Colors.white,),
              onPressed: null,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,


      body: SingleChildScrollView(
        child: FutureBuilder<UserModel?>(
    future:  UserRepository().getUserById(widget.userId),
    builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.white,));
        }

        else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
                child: Text("Error:${snapshot.error.toString()}"));
          }

          else if (snapshot.hasData) {
            userData = snapshot.data;

            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: GestureDetector(
                          onLongPress: (){

                          },
                          child: ClipOval(
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: userData?.userImage != null
                                  ? Image.file(
                                File(userData!.userImage??''),
                                fit: BoxFit.cover,
                                height: 300,width: 300,
                              )

                                    : const Icon(Icons.person_outlined,color: Colors.white,size: 100,),
                              ),
                          ),
                        ),

                      ),
              IconButton(
                onPressed: () async {
                  await _pickImage();
                  if (_image != null) {
                    try {
                      setState(() {
                        loading = true;
                        isSuccess = false;
                        isError = false;
                      });
                      var data = {
                        "userId": widget.userId,
                        "userImage": _imagePath,
                      };
                      var updateEmailResult = await UserRepository().update(data, widget.userId);
                      if (updateEmailResult > 0) {
                        setState(() {
                          loading = false;
                          isSuccess = true;
                          isError = false;
                        });
                      } else {
                        setState(() {
                          loading = false;
                          isSuccess = false;
                          isError = true;
                        });
                      }
                    } catch (e) {
                      setState(() {
                        loading = false;
                        isSuccess = false;
                        isError = true;
                        error = "Exp: ${e.toString()}";
                      });
                    }
                  }
                },
                icon: Icon(Icons.add_a_photo_outlined, color: Colors.white),
              ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userData?.userName ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit,color: Colors.white,),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Update your name'),
                                  content: Form(
                                    key: formKey,
                                    child: TextFormField(
                                      autovalidateMode:AutovalidateMode.onUserInteraction,
                                      validator: (value){
                                        if(value == null || value.isEmpty) {
                                          return "*Value is Null";
                                        }

                                        if(value.length < 4) {
                                          return "User name must be more than 4 !!";
                                        }
                                        return null;
                                      },
                                      controller: userNamectr,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        labelStyle: TextStyle(color: Colors.black),
                                        labelText: 'New Name',
                                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(
                                              Colors.black)),
                                      onPressed: () async {
                                        if(formKey.currentState!.validate()) {
                                          try {
                                            setState(() {
                                              loading = true;
                                              isSuccess = false;
                                              isError = false;
                                            });
                                            var data = {
                                              "userId": widget.userId,
                                              "userName": userNamectr.text.trim(),
                                            };
                                            var updateNameResult = await UserRepository().update(
                                                data, widget.userId);
                                            if (updateNameResult > 0) {
                                              setState(() {
                                                loading = false;
                                                isSuccess = true;
                                                isError = false;
                                              });
                                              Navigator.of(context).pop(true);
                                            } else {
                                              setState(() {
                                                loading = false;
                                                isSuccess = false;
                                                isError = true;
                                              });
                                            }
                                          } catch (e) {
                                            setState(() {
                                              loading = false;
                                              isSuccess = false;
                                              isError = true;
                                              error = "Exp: ${e.toString()}";
                                            });
                                          }
                                        }
                                      },
                                      child: const Text('Update', style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    color: Colors.black,
                    margin: const EdgeInsets.fromLTRB(5,0,0,0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      title: Text(userData?.userEmail ?? '',
                          style: const TextStyle(color: Colors.white)),
                      trailing: IconButton(

                        icon: Icon(Icons.edit,color: Colors.white,),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Update your email'),
                                content: Form(
                                  key: formKey2,
                                  child: TextFormField(
                                    autovalidateMode:AutovalidateMode.onUserInteraction,
                                    validator: (value){
                                      if(value == null|| value.isEmpty) {
                                        return "*Value is Null";
                                      }

                                      if(!value.contains('@') || !value.contains(".com") && !value.contains(".net")) {
                                        return "This is not an Email !!";
                                      }
                                      return null;
                                    },

                                    keyboardType: TextInputType.emailAddress,
                                    controller: userEmailctr,
                                    onChanged: (value) {
                                      userEmailctr.text = value;
                                    },
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(color: Colors.black),
                                      labelText: 'New email',
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            Colors.black)),
                                    onPressed: () async {
                                      if(formKey2.currentState!.validate()) {
                                        try {
                                          setState(() {
                                            loading = true;
                                            isSuccess = false;
                                            isError = false;
                                          });
                                          var data = {
                                            "userId": widget.userId,
                                            "userEmail": userEmailctr.text.trim(),
                                          };
                                          var updateEmailResult = await UserRepository()
                                              .update(data, widget.userId);
                                          if (updateEmailResult > 0) {
                                            setState(() {
                                              loading = false;
                                              isSuccess = true;
                                              isError = false;
                                            });
                                            Navigator.of(context).pop(true);
                                          } else {
                                            setState(() {
                                              loading = false;
                                              isSuccess = false;
                                              isError = true;
                                            });
                                          }
                                        } catch (e) {
                                          setState(() {
                                            loading = false;
                                            isSuccess = false;
                                            isError = true;
                                            error = "Exp: ${e.toString()}";
                                          });
                                        }
                                      }
                                    },
                                    child: const Text('Update', style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
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
