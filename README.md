A GraphQL library. Quite minimal and hopefully easy to use.
GQL Subscriptions are not handled yet.

## Usage

A simple usage example:

```dart
// /!\ It seem the API used in this example no longer exist. 
import 'package:simple_gql/simple_gql.dart';

main() {
  try {
    final client = GQLClient(
      url: 'https://api.graph.cool/simple/v1/swapi',
    );
    final response = await client.query(
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
    print(response);
  } on GQLError catch(e){
    print('here is a GraphQL error : $e');
  } catch(e) {
    print('unknown error. Usually due to a bad URL or problem with the connection');
    print(e);
  }
}
```