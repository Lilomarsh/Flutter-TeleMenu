import 'package:flutter/material.dart';
import '../constants.dart';

class CustomTextArea extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  String _boxError(String str)
  {
    switch(hint)
    {
      case 'Enter your name': return'Name is empty';
      case 'Enter your email': return'email is empty';
      case 'Enter your age': return'age is empty';
      case 'Enter your password': return'Password is empty';
    }
  }
  CustomTextArea({@required this.onClick,@required this.icon, @required this.hint}); //require them from the constructor

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator:(value)
          {
            if(value.isEmpty)
              {
                return _boxError(hint);
              // ignore: missing_return
              }

            },
        onSaved: onClick,
        obscureText: hint =='Enter your password' ? true: false,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
              icon
          ),
          filled: true,
          fillColor: kInputColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color:Colors.white

              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color:Colors.white

              )
          ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color:Colors.white

            )
        ),
        ),
      ),
    );
  }
}