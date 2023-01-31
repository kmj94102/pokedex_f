import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_f/model/type_info.dart';
import 'package:pokedex_f/utils/constants.dart';

Widget listDrawer(
    List<TypeCondition> typeList,
    Function(int, bool) typeChangeListener,
    ) {
  return Drawer(
    child: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              const Text(
                "조건",
                style: TextStyle(
                    fontFamily: fontMaruBuri,
                    color: Color(0xFFED6035),
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => const Color(0xFFED6035))),
                  child: const Text(
                    '초기화',
                    style: TextStyle(
                        fontFamily: fontMaruBuri,
                        fontSize: 14,
                        color: Colors.white),
                  ))
            ],
          ),
        ),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            for (var index = 0; index <= typeList.length - 1; index++)
              GestureDetector(
                onTap: () {
                  typeChangeListener(index, !typeList[index].isSelect);
                },
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(
                      typeList[index].image,
                      width: 55,
                      height: 55,
                    ),
                    if (!typeList[index].isSelect)
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0x80000000), shape: BoxShape.circle),
                        width: 52,
                        height: 52,
                      )
                  ],
                ),
              )
          ],
        ),
        
      ],
    ),
  );
}
