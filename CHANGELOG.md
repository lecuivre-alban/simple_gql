## 1.2.0 Null Safety
 - Migration to null safety
 - Added getter for http response if you want to access additional information.

## 1.1.2 Global default headers
 - Added possibility to set default headers for all GQLClient that will be created.

## 1.1.1 Minor changes
 - Added getter to GQLClient's headers property

## 1.1.0 **Breaking changes**
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

## 1.0.0 Initial release
 - Support GQL Queries and Mutations
