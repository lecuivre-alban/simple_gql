## 1.1.0
**Breaking Changes**
- new object GQLClient used to define the URL and headers shared between queries.
New usage example :
```dart
final client = GQLClient(
    url: 'https://url.com'
    headers: {'Authorization': 'Bearer $token'}
);

client.query(...);
// or
client.mutation(...);
```

- New managment of errors. Now, use a try/catch to catch errors. For more precision, use :
```dart
try{
    client.query(...);
} on GQLError catch(gqlError){
    // do stuff
} catch(e){
    // do other stuff
}
```

## 1.0.0
 - Support GQL Queries and Mutations
