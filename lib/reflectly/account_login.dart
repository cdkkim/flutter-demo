import 'package:flutter/material.dart';

class AccountLogin extends StatefulWidget {
  const AccountLogin({Key? key}) : super(key: key);

  @override
  _AccountLoginState createState() => _AccountLoginState();
}

class _AccountLoginState extends State<AccountLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Account', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                    Text('Login', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                    ),
                    TextButton(onPressed: () {}, child: Text('FORGOT?')),
                  ],
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text('Submit')),
              const SizedBox(height: 20),
              Text('By signing in, you are agreeing to our'),
              Text('Terms of Service and Privacy Policy'),
            ],
          ),
        ),
      ),
    );
  }
}
