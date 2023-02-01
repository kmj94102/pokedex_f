import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_f/model/type_info.dart';
import 'package:pokedex_f/utils/constants.dart';

Widget listDrawer(
    {required List<TypeCondition> typeList,
    required List<int> generationList,
    required Function(int, bool) typeChangeListener,
    required Function(int) generationChangeListener,
    required VoidCallback resetListener}) {
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
                  onPressed: () {
                    resetListener();
                  },
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
        const SizedBox(height: 40,),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: generationButton(
                  generation: 1,
                  onPressed: () {
                    generationChangeListener(1);
                  },
                  isSelect: generationList.contains(1)),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: generationButton(
                  generation: 2,
                  onPressed: () {
                    generationChangeListener(2);
                  },
                  isSelect: generationList.contains(2)),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: generationButton(
                  generation: 3,
                  onPressed: () {
                    generationChangeListener(3);
                  },
                  isSelect: generationList.contains(3)),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: generationButton(
                  generation: 4,
                  onPressed: () {
                    generationChangeListener(4);
                  },
                  isSelect: generationList.contains(4)),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: generationButton(
                  generation: 5,
                  onPressed: () {
                    generationChangeListener(5);
                  },
                  isSelect: generationList.contains(5)),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: generationButton(
                  generation: 6,
                  onPressed: () {
                    generationChangeListener(6);
                  },
                  isSelect: generationList.contains(6)),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: generationButton(
                  generation: 7,
                  onPressed: () {
                    generationChangeListener(7);
                  },
                  isSelect: generationList.contains(7)),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: generationButton(
                  generation: 8,
                  onPressed: () {
                    generationChangeListener(8);
                  },
                  isSelect: generationList.contains(8)),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: generationButton(
                  generation: 9,
                  onPressed: () {
                    generationChangeListener(9);
                  },
                  isSelect: generationList.contains(9)),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget generationButton(
    {required int generation,
    required VoidCallback onPressed,
    required isSelect}) {
  return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        primary: Colors.black,
          backgroundColor:
              isSelect ? const Color(0xFFFFF6A8) : const Color(0x80000000),
          side: const BorderSide(color: Color(0xFFED6035), width: 1)),
      child: Text(
        "$generation 세대",
        style: const TextStyle(
            fontFamily: fontMaruBuri,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ));
}
