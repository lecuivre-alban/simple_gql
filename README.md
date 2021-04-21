A GraphQL library. Quite minimal and hopefully easy to use.
GQL Subscriptions are not handled yet.

## Usage

A simple usage example:

```dart
// /!\ It seem the API used in this example no longer exist. 
import 'package:simple_gql/simple_gql.dart';

main() {
  try {
    final response = await GQLClient(
      'https://graphqlzero.almansi.me/api',
    ).query(
      query: r'''
        query todos($options: PageQueryOptions) {
          todos(options: $options) {
            data {
              id
              title
              completed
              user {
                id
                username
                website
              }
            }
          }
        }
      ''',
      variables: {
        'options': {
          'paginate': {
            'page': 0,
            'limit': 1,
          },
        },
      },
    );
    print('Yay, success ! :D');
    print(response);
  } on GQLError catch (e) {
    print('Ouch ! :(');
    print(e);
  } catch (e) {
    print('Probably a network error');
    print(e);
  }
}
```