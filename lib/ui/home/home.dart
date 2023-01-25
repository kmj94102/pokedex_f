import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_f/ui/list/list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), (){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const ListScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: const [Text('홈 화면')],
        ),
      ),
    );
  }
}
