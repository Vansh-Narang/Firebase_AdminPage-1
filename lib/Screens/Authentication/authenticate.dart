import 'package:flutter/material.dart';
import 'package:flutter_application_20/Screens/MemberPage/MemberDetail.dart';

class Authenticate_Page extends StatefulWidget {
  const Authenticate_Page({super.key});

  @override
  State<Authenticate_Page> createState() => _Authenticate_PageState();
}

class _Authenticate_PageState extends State<Authenticate_Page> {
  @override
  Widget build(BuildContext context) {
    return Container(child: SignIn());
  }
}
