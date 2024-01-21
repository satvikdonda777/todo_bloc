import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo_demo/config/navigation/app_route.dart';
import 'package:todo_demo/core/core.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer _t;

  @override
  void initState() {
    _t = Timer.periodic(const Duration(seconds: 3), (timer) {
      _t.cancel();
      context.router.replace(const TodoListPageRoute());
    });
    super.initState();
  }

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Todo Demo',
          style: FontUtilities.style(
            fontSize: 55,
            fontWeight: FWT.black,
          ),
        ),
      ),
    );
  }
}
