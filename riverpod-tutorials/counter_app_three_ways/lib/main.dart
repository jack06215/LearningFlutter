// https://github.com/funwithflutter/riverpod_tutorials/blob/main/riverpod_001_counter_app_three_ways/lib/pages/counter_state_notifier_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:counter_app_three_ways/pages/counter_change_notifier_page.dart';
import 'package:counter_app_three_ways/pages/counter_state_notifier_page.dart';
import 'package:counter_app_three_ways/pages/counter_state_provider_page.dart';

const changeNotifierRoute = 'changeNotifier';
const stateNotifierRoute = 'stateNotifier';
const stateProviderRoute = 'stateProvider';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Enable Riverpod for the entire applications
    return ProviderScope(
      child: MaterialApp(
        title: 'Material App',
        initialRoute: '/',
        routes: {
          '/': (context) => const Home(),
          changeNotifierRoute: (context) => const CounterChangeNotifierPage(),
          stateNotifierRoute: (context) => const CounterStateNotifierPage(),
          stateProviderRoute:(context) => const CounterStateProvider(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.red[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, changeNotifierRoute);
                },
                child: const Text('Change Notifier'),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0)),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, stateNotifierRoute);
                },
                child: const Text('State Notifier'),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0)),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, stateProviderRoute);
                },
                child: const Text('State Provider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
