import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';

class AnimatedButton extends StatelessWidget {
  const AnimatedButton({
    super.key,
    required this.height,
    required this.width,
    required AnimationController animationController,
  }) : _animationController = animationController;

  final double height;
  final double width;
  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        borderRadius: BorderRadius.circular(20), // Adjust radius as needed
      ),
      duration: Duration(milliseconds: 200),
      height: height,
      width: width,
      child: TextButton(
        onPressed: () async {
          BlocProvider.of<HomeBloc>(context).add(LoadBatteryEvent());
          _animationController.forward();
        },
        child: Text(
          "Get Battery Level",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
