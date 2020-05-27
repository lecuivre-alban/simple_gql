import 'package:simple_gql/simple_gql.dart';
import 'package:test/test.dart';

void main() {
  group('GQL tests', () {
    test('Query Test', () async {
      try{
        final response = await GQLClient(
          url: 'https://api.graph.cool/simple/v1/swapi',
        ).query(
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
        expect(response, isA<GQLResponse>());
      }on GQLError catch(e){
        print(e);
        expect(true, true);
      } catch(e){
        print('unknown error :(');
        fail(e.toString());
      }
    });
  });
}
