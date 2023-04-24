import 'dart:math';

import 'package:digital_card_consolidation/apiSecrets.dart';
import 'package:test/test.dart';
import 'package:pokemon_tcg/pokemon_tcg.dart';

void main() {
  final random = Random();

  group('Pokemon API Tests', () {
    late PokemonTcgApi apiConnection;
    setUp(() => {apiConnection = PokemonTcgApi(apiKey: pokemonTcgApiKey)});
    test('Get Random Set is in range', () async {
      final allSets = await apiConnection.getSets();
      List<int> indexTests = [];
      // Generate random integers up to the last set number
      for (int iter = 0; iter < 50; iter++) {
        indexTests.add(random.nextInt(allSets.length + 1));
      }
      // Check does each set number is greater than or equal to zero and less than or eqaul to the last set number
      for (int val in indexTests) {
        expect(true, (0 <= val && val <= allSets.length));
      }
    });
    test('Get Random Card is in range', () async {
      final allSets = await apiConnection.getSets();
      final set = allSets[0];
      List<int> indexTests = [];
      // Generate random integers up to the total of cards in the set plus one
      // Zero is not valid
      for (int iter = 0; iter < 50; iter++) {
        indexTests.add(random.nextInt(set.total) + 1);
      }
      // Check does each card number is greater than or equal to one and less than or equal to the total of cards in a set
      for (int val in indexTests) {
        expect(true, (1 <= val && val <= set.total));
      }
    });
  });
}
