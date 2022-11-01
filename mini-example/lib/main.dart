import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example 5: Create User',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: HomePage(),
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

/* Example 3: FutureProvider
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
*/

/* Example 4: StreamProvider
final names = [
  'Alice',
  'Bob',
  'Charlie',
  'Dean',
  'Eva',
  'Fred',
  'Gates',
  'Henry',
  'Issac',
];
final tickerProvider = StreamProvider<int>(((ref) {
  return Stream.periodic(const Duration(seconds: 1), (i) => i + 1);
}));
final namesProvider = StreamProvider<List<String>>(((ref) {
  final ticker = ref.watch(tickerProvider.stream);
  return ticker.map((count) => names.getRange(0, count).toList());
}));

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(title: const Text('Example 4: StreamProvider')),
        body: Consumer(
          builder: (context, ref, child) {
            final names = ref.watch(namesProvider);
            return names.when(
                data: (data) => ListView.builder(
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text(data[index]),
                        );
                      }),
                      itemCount: data.length,
                    ),
                error: ((error, stackTrace) {
                  return Text('Error: $error');
                }),
                loading: () => const CircularProgressIndicator());
          },
        ));
  }
}
*/

/* Example 5: ChangeNotifier & ChangeNotifierProvider
class Person {
  final String id;
  final String name;
  final int age;

  Person({required this.name, required this.age, String? uuid})
      : id = uuid ?? const Uuid().v4();
  Person updated([String? name, int? age]) => Person(
        name: name ?? this.name,
        age: age ?? this.age,
        uuid: id,
      );
  String get displayName {
    return '$name ($age years old)';
  }

  @override
  bool operator ==(covariant Person other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class DataModel extends ChangeNotifier {
  final List<Person> _people = [];
  int get count => _people.length;
  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);
  void add(Person person) {
    _people.add(person);
    notifyListeners();
  }

  void update(Person person) {
    final index = _people.indexOf(person);
    _people[index] = person;
    notifyListeners();
  }
}

final peopleProvider = ChangeNotifierProvider((_) => DataModel());

class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final people = ref.watch(peopleProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Example 5: Create User')),
      body: Consumer(
        builder: (context, ref, child) {
          final dataModel = ref.watch(peopleProvider);
          return ListView.builder(
              itemCount: dataModel.count,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: GestureDetector(
                      onTap: () async {
                        final current = dataModel.people[index];
                        final person = await showUpdateUserDialog(context,
                            nameController: nameController,
                            ageController: ageController,
                            person: current);
                        if (person != null) {
                          dataModel.update(person);
                        }
                      },
                      child: Text(dataModel.people[index].displayName)),
                );
              }));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () async {
          final person = await showUpdateUserDialog(context,
              nameController: nameController, ageController: ageController);
          if (person != null) {
            final dataModel = ref.read(peopleProvider);
            dataModel.add(person);
          }
        },
      ),
    );
  }

  Future<Person?> showUpdateUserDialog(BuildContext context,
      {required TextEditingController nameController,
      required TextEditingController ageController,
      Person? person}) {
    String? name = person?.name;
    int? age = person?.age;
    nameController.text = name ?? '';
    ageController.text = age?.toString() ?? '';
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(person == null ? 'Create a user' : 'Update a user'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(label: Text('User Name')),
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(label: Text('User Age')),
              onChanged: (value) => age = int.tryParse(value),
            )
          ]),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, null);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  print('Saving id:${person?.id}, name:$name, age:$age');
                  if (name != null && age != null) {
                    if (person == null) {
                      Navigator.pop(context, Person(name: name!, age: age!));
                    } else {
                      Navigator.pop(context, person.updated(name, age));
                    }
                  }
                },
                child: const Text('Save')),
          ],
        );
      },
    );
  }
}
*/

class Film {
  final String id;
  final String title;
  final String description;
  bool isFavorite = false;
  Film(this.id, this.title, this.description);
}

final films = [
  Film('A-1', 'Star Wars I', 'Description for Star Wars I'),
  Film('A-2', 'Star Wars II', 'Description for Star Wars II'),
  Film('A-3', 'Star Wars III', 'Description for Star Wars III'),
  Film('A-4', 'Star Wars IV', 'Description for Star Wars IV'),
];

class FilmNotifier extends StateNotifier<List<Film>> {
  FilmNotifier() : super(films);
  void setFavorite(String id, bool isFavorite) {
    state = state.map((film) {
      if (film.id == id) {
        film.isFavorite = isFavorite;
        return film;
      } else {
        return film;
      }
    }).toList();
  }
}

enum FavoriteStatus {
  all,
  favorite,
  notFavorite,
}

final favoriteStatusProvider =
    StateProvider<FavoriteStatus>((_) => FavoriteStatus.all);

final allFilmsProvider =
    StateNotifierProvider<FilmNotifier, List<Film>>((_) => FilmNotifier());

final favoriteFilmsProvider = Provider<List<Film>>((ref) {
  final allFilms = ref.watch(allFilmsProvider);
  return allFilms.where((film) => film.isFavorite).toList();
});

final notFavoriteFilmsProvider = Provider<List<Film>>((ref) {
  final allFilms = ref.watch(allFilmsProvider);
  return allFilms.where((film) => !film.isFavorite).toList();
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example 6: StateNotifierProvider')),
      body: Column(
        children: [
          const FilterWidget(),
          Expanded(
            child: Consumer(builder: ((context, ref, child) {
              final favoriteStatus = ref.watch(favoriteStatusProvider);
              switch (favoriteStatus) {
                case FavoriteStatus.all:
                  return FilmsWidget(provider: allFilmsProvider);
                case FavoriteStatus.favorite:
                  return FilmsWidget(provider: favoriteFilmsProvider);
                case FavoriteStatus.notFavorite:
                  return FilmsWidget(provider: notFavoriteFilmsProvider);
              }
            })),
          )
        ],
      ),
    );
  }
}

class FilmsWidget extends ConsumerWidget {
  final AlwaysAliveProviderBase<List<Film>> provider;
  const FilmsWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return ListView.builder(
        itemCount: films.length,
        itemBuilder: ((context, index) {
          final film = films[index];
          return ListTile(
            title: Text(film.title),
            subtitle: Text(film.description),
            trailing: IconButton(
              icon: Icon(
                  film.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                ref
                    .read(allFilmsProvider.notifier)
                    .setFavorite(film.id, !film.isFavorite);
              },
            ),
          );
        }));
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final filter = ref.watch(favoriteStatusProvider);
        return DropdownButton(
          value: filter,
          items: FavoriteStatus.values
              .map((e) => DropdownMenuItem(
                    child: Text(e.name.split('.').last),
                    value: e,
                  ))
              .toList(),
          onChanged: (value) {
            ref.read(favoriteStatusProvider.state).state = value!;
          },
        );
      },
    );
  }
}
