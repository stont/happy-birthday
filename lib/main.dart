// main.dart
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math' show pi;  // Added for pi constant

void main() {
  runApp(BirthdayApp());
}

class BirthdayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthday Surprise',
      theme: ThemeData(
        primaryColor: Color(0xFFFF69B4), // Chromatic pink
        scaffoldBackgroundColor: Colors.white,
      ),
      home: NameEntryScreen(),
    );
  }
}

class NameEntryScreen extends StatefulWidget {
  @override
  _NameEntryScreenState createState() => _NameEntryScreenState();
}

class _NameEntryScreenState extends State<NameEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  int _attempts = 0;

  void _checkName() {
    if (_firstNameController.text.trim().toLowerCase() == "temitayo" &&
        _lastNameController.text.trim().toLowerCase() == "badewole") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BirthdaySurpriseScreen()),
      );
    } else {
      setState(() {
        _attempts++;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            _attempts == 1
                ? "Oops, I guess the app was installed by the wrong person. Let me check the next flat."
                : "👏 ahahahaha! So you don't know your name. 🤣🤣🤣🤣\nOk sorry for the laugh. Try again.",
          ),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF69B4),
              Color(0xFFFF1493),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            "Welcome!",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF69B4),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: "First Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              labelText: "Last Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFF69B4),  // Changed from primary to backgroundColor
                              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            ),
                            onPressed: _checkName,
                            child: Text(
                              "Enter",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BirthdaySurpriseScreen extends StatefulWidget {
  @override
  _BirthdaySurpriseScreenState createState() => _BirthdaySurpriseScreenState();
}

class _BirthdaySurpriseScreenState extends State<BirthdaySurpriseScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 5));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFF69B4),
                  Color(0xFFFF1493),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage('assets/birthday_person.png'),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "🎈 Happy Birthday, Temitayo! 🎈",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      """Dear Temitayo,

On this special day, I want to celebrate the amazing person you are. Your friendship has been a true blessing in my life. Your kindness, wisdom, and infectious laughter make every moment brighter.

May this year bring you endless joy, countless reasons to smile, and all the success you deserve. You're not just a friend, you're family.

Thank you for being uniquely you! 🌟

With love and best wishes,
David Oluwabusayo ❤️""",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 5,
              minBlastForce: 2,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.1,
              colors: [
                Colors.pink,
                Colors.white,
                Colors.purple,
                Colors.yellow,
                Colors.blue,
              ],
            ),
          ),
        ],
      ),
    );
  }
}