import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  static const platform = MethodChannel('samples.flutter.dev/battery');
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
      duration: const Duration(milliseconds: 200),
    );
    sizeTween = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 90,),
            ScaleTransition(
              scale: sizeTween,
              child: SizedBox(
                height: 400,
                child: LottieBuilder.asset("assets/batteryAnimation.json"),
              ),
            ),
            SizedBox(height: 20),
            Text(
              _batteryLevel,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(
                height: 20),
            AnimatedContainer(
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .colorScheme
                    .inversePrimary,
                borderRadius: BorderRadius.circular(
                  20,
                ), // Adjust radius as needed
              ),
              duration: Duration(milliseconds: 200),
              height: height,
              width: width,
              child: TextButton(
                onPressed: () async {
                  await _getBatteryLevel();
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
}
