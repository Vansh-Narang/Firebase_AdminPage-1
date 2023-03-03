import 'package:flutter/material.dart';
import 'package:flutter_application_20/Screens/Authenticate/authenticate.dart';
import 'package:flutter_application_20/Screens/home/Home.dart';

class Wrapper_1 extends StatefulWidget {
  const Wrapper_1({super.key});

  @override
  State<Wrapper_1> createState() => _Wrapper_1State();
}

class _Wrapper_1State extends State<Wrapper_1> {
  @override
  Widget build(BuildContext context) {
    return Authenticate_Page();
  }
}
