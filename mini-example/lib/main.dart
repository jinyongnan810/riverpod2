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
      title: 'Example 3: FutureProvider',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

/* Example 1: Simple Provider
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

/* Example 2: StateNotifier & StateNotifierProvider
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
*/

enum City {
  beijing,
  tokyo,
  paris,
}

typedef WeatherEmoji = String;
const weather = {
  City.beijing: '🌨️',
  City.tokyo: '🌤️',
  City.paris: '🌞',
};
const unknown = '🤔';

Future<WeatherEmoji> getWeather(City city) async {
  await Future<void>.delayed(const Duration(seconds: 1));
  return weather[city]!;
}

final cityProvider = StateProvider<City?>((ref) => null);

final weatherProvider = FutureProvider<WeatherEmoji>(((ref) {
  final city = ref.watch(cityProvider);
  if (city == null) return unknown;
  return getWeather(city);
}));

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final city = ref.watch(cityProvider);
    final currentWeather = ref.watch(weatherProvider);
    return Scaffold(
        appBar: AppBar(title: const Text('Example 3: FutureProvider')),
        body: Column(
          children: [
            currentWeather.when(
              data: (String data) {
                return Text('The weather is $data');
              },
              error: (Object error, StackTrace stackTrace) {
                return const Text('Fetching weather failed');
              },
              loading: () {
                return const CircularProgressIndicator();
              },
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: ((context, index) {
                final currentCity = City.values[index];
                final isSelected = currentCity == city;
                return ListTile(
                  title: Text(currentCity.toString()),
                  onTap: () {
                    ref.read(cityProvider.notifier).state = currentCity;
                  },
                  trailing: isSelected ? const Icon(Icons.check) : null,
                );
              }),
              itemCount: City.values.length,
            ))
          ],
        ));
  }
}
