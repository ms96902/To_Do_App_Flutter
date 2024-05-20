import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:to_do_app/todolistpage.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login/Signup',
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'PoetsenOne',
            color: Color(0xFF3D52A0),
          ),
        ),
        backgroundColor: Color(0xFFADBBDA),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFADBBDA), Color(0xFFEDE8F5)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'QuickTask',
                    style: TextStyle(
                      fontSize: 70,
                      fontFamily: 'PoetsenOne',
                      color: Color(0xFF3D52A0),
                    ),
                  ),
                  const Text(
                    'Your Everyday To-do Management App',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'PoetsenOne',
                      color: Color(0xFF3D52A0),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.white),
                      filled: true,
                      fillColor: Colors.blueGrey[700],
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      filled: true,
                      fillColor: Colors.blueGrey[700],
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 30),
                  _isLoading
                      ? CircularProgressIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: _signUp,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 24.0),
                                backgroundColor: Colors.green,
                                textStyle: TextStyle(fontSize: 18),
                              ),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontFamily: 'PoetsenOne',
                                    color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _logIn,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 24.0),
                                backgroundColor: Colors.blue,
                                textStyle: TextStyle(fontSize: 18),
                              ),
                              child: Text(
                                'Log In',
                                style: TextStyle(
                                    fontFamily: 'PoetsenOne',
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final user = ParseUser.createUser(username, password, null);

    var response = await user.signUp(allowWithoutEmail: true);

    setState(() {
      _isLoading = false;
    });

    if (response.success) {
      // Navigate to task list screen
      showSuccess();
    } else {
      // Show error message
      showError(response.error!.message);
    }
  }

  void showSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: const Text("User was successfully created!"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _logIn() async {
    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    final user = ParseUser(username, password, null);

    var response = await user.login();

    setState(() {
      _isLoading = false;
    });

    if (response.success) {
      // Navigate to task list screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TodoListPage()),
      );
    } else {
      // Show error message
      showError(response.error!.message);
    }
  }
}
