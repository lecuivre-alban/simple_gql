import 'package:simple_gql/simple_gql.dart' as gql;

void main() async {
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
  if(response.hasErrors){
    print('Ouch ! :(');
  } else {
    print('Yay ! :D');
  }
}
