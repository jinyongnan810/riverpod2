import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example 2: StateNotifierProvider',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

/* Example 1
final dateTimeProvider = Provider<DateTime>((ref) => DateTime.now());

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateTimeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Example 1: Basic Provider')),
      body: Center(child: Text(date.toIso8601String())),
    );
  }
}
*/

class Counter extends StateNotifier<int> {
  Counter() : super(0);
  void increment() {
    state += 1;
  }
}

final counterProvider = StateNotifierProvider<Counter, int>(
  (ref) => Counter(),
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example 2: StateNotifierProvider')),
      body: Consumer(builder: ((context, ref, child) {
        final count = ref.watch(counterProvider);
        return Center(child: Text(count.toString()));
      })),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () {
          ref.read(counterProvider.notifier).increment();
        },
      ),
    );
  }
}
