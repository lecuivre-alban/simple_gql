import 'package:simple_gql/simple_gql.dart';

void main() async {
  try {
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
    print('Yay, success ! :D');
    print(response);
  } on GQLError catch (e) {
    print('Ouch ! :(');
    print(e);
  } catch (e) {
    print('Probably a network error');
  }
}
