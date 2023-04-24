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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ! Future Navigation !
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
              Container(
                padding: EdgeInsets.all(20),
                child: LandingPage(),
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
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall;

    return FutureBuilder(
      future: randomCard,
      builder: (context, AsyncSnapshot<PokemonCard> snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Column(
              children: [
                Text(
                  "Today's Random Card",
                  style: style,
                ),
                SingleCard(card: snapshot.data),
              ],
            ),
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
        padding: const EdgeInsets.all(3),
        child: Image.network("${card?.images.small}"),
      ),
    );
  }
}
