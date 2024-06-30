import 'package:bkash_ui/controllers/login.dart';
import 'package:bkash_ui/widgets/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Image.asset(
                //   'assets/amazon_logo.png',
                //   height: 80.0,
                //   errorBuilder: (context, error, stackTrace) {

                //   },
                // ),
                SizedBox(height: 20.0),
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Username',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                  controller: _nameController,
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                  controller: _usernameController,
                ),
                SizedBox(height: 20.0),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  controller: _passwordController,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => BottomNavigation()),
                    // );
                    // Aksi login di sini
                    Map<String, dynamic> data = {
                      'name': _nameController.text,
                      'email': _usernameController.text,
                      'password': _passwordController.text,
                      'role': 'User',
                    };

                    registerAndSaveData(data);
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    // Aksi forgot password di sini
                  },
                  child: Text(
                    'Selamat Datang Di Aplikasi Bank Sampah',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
                SizedBox(height: 20.0),
                // Text(
                //   'New to Amazon?',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 16.0,
                //   ),
                // ),
                SizedBox(height: 10.0),
                // ElevatedButton(
                //   onPressed: () {
                //     // Aksi create account di sini
                //   },
                //   style: ElevatedButton.styleFrom(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                //     backgroundColor: Colors.grey,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //     ),
                //   ),
                //   child: Text(
                //     'Create your Amazon account',
                //     style: TextStyle(
                //       fontSize: 18.0,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
