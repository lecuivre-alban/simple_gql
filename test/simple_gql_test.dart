import 'package:simple_gql/simple_gql.dart' as gql;
import 'package:test/test.dart';

void main() {
  group('GQL tests', () {
    test('Query Test', () async {
      final response = await gql.query(
        url: 'https://api.graph.cool/simple/v1/swapi',
        query: r'''
          query {
            allPersons {
              name
              films {
                director
              }
            }
          }
        ''',
      );
      expect(response.hasErrors, isFalse);
    });
  });
}
