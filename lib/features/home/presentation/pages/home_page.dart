import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';
import '../widgets/animated_battery.dart';
import '../widgets/animated_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> sizeTween;
  String _batteryLevel = 'Tap to get Battery Level';
  double height = 0;
  double width = 0;

  @override
  void initState() {
    super.initState();
    // Delay animation slightly to ensure it happens on screen load
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        width = 200;
        height = 60;
      });
    });
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    sizeTween = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Battery App"),
      ),
      body: Center(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 90),
                AnimatedBattery(sizeTween: sizeTween),
                SizedBox(height: 20),
                Text(
                  state is! BatteryLoaded ? _batteryLevel : state.batteryLevel,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 20),
                AnimatedButton(
                  height: height,
                  width: width,
                  animationController: _animationController,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
