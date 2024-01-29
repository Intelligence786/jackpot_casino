import 'package:flutter/material.dart';

class RewardItem {
  final String name;
  final Widget icon;
  final Function()? effect;

  RewardItem({required this.name, required this.icon, this.effect});
}
