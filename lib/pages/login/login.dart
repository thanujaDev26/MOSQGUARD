import 'package:flutter/material.dart';
import 'package:mosqguard/auth/auth.dart';
import 'package:mosqguard/pages/dashboard/home.dart';
import 'package:mosqguard/pages/login/otp_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  final TextEditingController _phoneController = TextEditingController();


  void _signAnonymously(BuildContext context) async{
    try{
      await AuthService().signinInAnonymously();
      if(context.mounted){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
      }
    }
    catch(error){
      print("Error signing in anonymously: ${error}");
    }
  }

  Future<void> _signInWithGoogle () async{
    setState(() {
      _isLoading = true;
    });
    try{
      await AuthService().signinWithGoogle();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
    }
    catch(error){
      showDialog(context: context,
          builder: (context)=> AlertDialog(
            title: Text("Error"),
            content: Text("Error Signing in with Google: $error"),
            actions: [
              TextButton(onPressed: ()=>Navigator.of(context).pop(),
                  child: Text("OK"))
            ],
          )
      );
    }
  }

  void _sendOTP() {
    String phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isEmpty || phoneNumber.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter a valid phone number")),
      );
      return;
    }
    AuthService().sendOTP(phoneNumber, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPVerification(phoneNumber: phoneNumber),
        ),
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Enter Your Mobile Number',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/sri-lanka.png',
                            width: 40,
                            height: 30,
                          ),
                          const SizedBox(width: 1.0),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: '0778632148',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>_sendOTP(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      backgroundColor: const Color(0xff004DB9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Or'),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Column(
                    children: [

                      SocialButton(
                        icon: "assets/icons/guest-icon.png",
                        label: 'Continue as Guest',
                        onPressed: ()=> _signAnonymously(context),
                      ),
                      const SizedBox(height: 20.0),
                      SocialButton(
                        icon: "assets/icons/google.png",
                        label: 'Continue with Google',
                        onPressed: ()=>_signInWithGoogle(),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(
          icon,
          width: 24,
          height: 24,
        ),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          side: const BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
