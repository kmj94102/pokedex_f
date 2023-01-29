import 'package:flutter/material.dart';

enum StatusInfo {
  hp(name: 'HP', color: Color(0xFFEF5350)),
  attack(name: '공격', color: Color(0xFFFF7043)),
  defense(name: '방어', color: Color(0xFFFFCA28)),
  specialAttack(name: '특공', color: Color(0xFF42A5F5)),
  specialDefense(name: '특방', color: Color(0xFF66BB6A)),
  speed(name: '스피드', color: Color(0xFFEC407A)),;

  const StatusInfo({required this.name, required this.color});

  final String name;
  final Color color;

}