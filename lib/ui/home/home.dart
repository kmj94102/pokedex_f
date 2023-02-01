import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_f/ui/list/list.dart';
import 'package:pokedex_f/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.only(left: 24, right: 24, top: 30),
              elevation: 6,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ListScreen()));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 13),
                      child: const Text(
                        '전국 도감',
                        style: TextStyle(
                            fontFamily: fontMaruBuri,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFED6035)),
                      ),
                    ),
                    const Spacer(),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset('${imagesAddress}img_dex.png'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
