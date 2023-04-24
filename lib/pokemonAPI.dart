import 'package:pokemon_tcg/pokemon_tcg.dart';
import 'apiSecrets.dart';
import 'dart:math';

class PokeAPI {
  final apiConnection = PokemonTcgApi(apiKey: pokemonTcgApiKey);
  final random = Random();

  Future<PokemonCard> getRandomCard() async {
    final set = await getRandomSet();
    // Get the id of the set and a random number within the bounds of 1 - total in the set
    return await apiConnection
        .getCard("${set.id}-${random.nextInt(set.total) + 1}");
  }

  Future<CardSet> getRandomSet() async {
    final allSets = await apiConnection.getSets();
    return allSets[random.nextInt(allSets.length + 1)];
  }
}
