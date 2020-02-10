import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:simple_gql/src/GQLResponse.dart';

/// GQL Query using the Dart Http package
/// [url] is your gql endpoint.
/// 
/// [query] is your String query.
/// 
/// [variables] is the map of variables if your query need variables.
/// 
/// [headers] if you want to tweaks the request's headers.
/// 
/// Example
/// ```dart
/// import 'package:simple_gql/simple_gql.dart' as gql;
/// 
/// final response = await gql.query(
///   url: 'https://your_gql_endpoint',
///   query: r'''
///     query PostsForAuthor($id: Int!) {
///       author(id: $id) {
///          firstName
///         posts {
///           title
///           votes
///         }
///       }
///     }
///   ''',
///   variables: { 'id': 1 }
/// );
/// ```
Future<GQLResponse> query({
  @required String url,
  @required String query,
  Map<String,dynamic> variables,
  Map<String, String> headers
}) async {
  return await post(
    url,
    headers: (headers ?? {})..putIfAbsent('content-type', ()=>'application/json'),
    body: jsonEncode({
      'query': query,
      'variables': variables
    })
  ).then(
    (res){
      final body = jsonDecode(res.body);
      return GQLResponse(
        data: body['data'],
        errors: body['errors']
      );
    }
  );
}