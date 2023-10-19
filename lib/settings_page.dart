import 'package:flutter/material.dart';
import 'package:otaku_life/aboutUs_page.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _switchButton = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
  title: const Text("Settings"),
),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    title: const Text('Get notifications about anime',style: TextStyle(color: Colors.white)),
                    trailing: Switch(
                      activeColor: Colors.white,
                      activeTrackColor: Colors.white,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.grey,
                      value: _switchButton,
                      onChanged: (bool value) {
                        setState(() {
                          _switchButton = !_switchButton;
                        });
                      },
                    ),
                  ),
                ],
              ),
              // Add more sections with lines between them
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                height: 1,
                color: Colors.white,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Others',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AboutUs()),
                      );
                    },

                  child: const SizedBox(
                      height: 50,
                      width: 80,
                      child: Text('About us',style: TextStyle(color: Colors.white,fontSize: 17))),

                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
