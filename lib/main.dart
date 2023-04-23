import 'package:flutter/material.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'package:digital_card_consolidation/pokemonAPI.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Card Consolidation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'DCC Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Column(
            children: [
              // SafeArea(
              //   child: NavigationRail(
              //     destinations: [],
              //     selectedIndex: selectedIndex,
              //     onDestinationSelected: (value) {
              //       setState(
              //         () {
              //           selectedIndex = value;
              //         },
              //       );
              //     },
              //   ),
              // ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: LandingPage(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<PokemonCard> randomCard = PokeAPI().getRandomCard();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: randomCard,
      builder: (context, AsyncSnapshot<PokemonCard> snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Today's Random Card"),
              SingleCard(card: snapshot.data),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class SingleCard extends StatelessWidget {
  const SingleCard({
    super.key,
    required this.card,
  });

  final PokemonCard? card;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Image.network("${card?.images.small}"),
      ),
    );
  }
}
