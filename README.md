A library for Dart developers.

## Usage

A simple usage example:

```dart
import 'package:simple_gql/simple_gql.dart';

main() {
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
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
