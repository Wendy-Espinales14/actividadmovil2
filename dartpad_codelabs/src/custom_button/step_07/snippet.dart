// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: CustomButton(
            color: Colors.cyan,
            child: Text("Button 1"),
            onTap: () => print('Button 1: Handle Tap/Click'),
            onLongPress: () => print('Button 1: Handle LongPress'),
          ),
        ),
      ),
    ),
  );
}

// Define a new intent here!

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    required this.child,
    required this.onTap,
    required this.onLongPress,
    this.color = Colors.blue,
  }) : super(key: key);

  final Color color;
  final Widget child;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _hovering = false;
  bool _focusing = false;

  @override
  Widget build(BuildContext context) {
    // Use a Shortcuts Widget to bind the Space and Enter Key to your Intent
    // Then, use an Actions widget to bind your Intent to the onTap callback
    // function provided by the user
    return Focus(
      onFocusChange: (focusing) => setState(() => _focusing = focusing),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  Color get color {
    if (_hovering) {
      return widget.color.withOpacity(0.75);
    } else if (_focusing) {
      return widget.color.withOpacity(0.5);
    }

    return widget.color;
  }
}
