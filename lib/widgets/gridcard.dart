import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  final void Function()? action;
  final IconData? icon;
  final String message;
  const GridCard({super.key, this.action, this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        footer: Icon(icon),
        child: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
