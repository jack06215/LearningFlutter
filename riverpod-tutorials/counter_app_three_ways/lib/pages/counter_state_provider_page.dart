import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _counterProvider = StateProvider<int>((ref) => 0);
final _isEvenProvider = Provider<bool>((ref) {
  final counter = ref.watch(_counterProvider);
  return (counter % 2 == 0);
});
final _evenCounter = Provider<int>((ref) {
  ref.listen<bool>(_isEvenProvider, (previous, next) {
    debugPrint('Previously $previous, and now $next');
    ref.state++;
  });
  return 0;
});

class CounterStateProvider extends ConsumerWidget {
  const CounterStateProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(_counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Provider Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: $counter'),
            const CounterIsEven(),
            const EvenCounter(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(_counterProvider.state).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterIsEven extends ConsumerWidget {
  const CounterIsEven({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEven = ref.watch(_isEvenProvider);
    return Text(isEven ? 'Is even' : 'Not even');
  }
}

class EvenCounter extends ConsumerWidget {
  const EvenCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final evenCount = ref.watch(_evenCounter);
    return Text(
      '$evenCount',
      style: const TextStyle(fontSize: 50),
    );
  }
}
