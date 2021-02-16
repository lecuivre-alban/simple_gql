/*
 * File Created: 2020-05-27 16:11
 * Author: Alban LECUIVRE
 * Copyright - 2020 Alban LECUIVRE
 */

part of simple_gql;

/// Class representing your GQL endpoint.
/// You can define [headers] to be used for each query/mutation.
class GQLClient {
  final String endpoint;
  Map<String, String> _headers;

  // General headers shared by all GQLClient created
  static Map<String, String> _generalHeaders;

  GQLClient(
    this.endpoint, {
    Map<String, String> headers,
  }) : _headers = headers ?? _generalHeaders ?? {};

  /// Method to set the headers used in the futures queries/mutations
  /// [headers] Headers that you want to set
  ///
  /// ```dart
  /// // Example
  /// client.setHeaders({'Authorization': 'Bearer $token'});
  /// ```
  void setHeaders(Map<String, String> headers) {
    _headers = headers;
  }

  /// Used to set default headers for all GQLClient that will be created.
  ///
  /// /// ```dart
  /// // Example
  /// GQLClient.setGeneralHeaders({'Authorization': 'Bearer $token'});
  /// ```
  static void setGeneralHeaders(Map<String, String> headers) {
    _generalHeaders = headers;
  }

  Map<String, String> get headers => _headers;

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
  /// import 'package:simple_gql/simple_gql.dart';
  ///
  /// final response = await GQLClient(
  ///   url: 'https://your_gql_endpoint',
  /// ).query(
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
  Future<GQLResponse> query(
      {@required String query,
      Map<String, dynamic> variables,
      Map<String, String> headers}) async {
    try {
      return await post(Uri.parse(endpoint),
              headers: (headers ?? _headers)
                ..putIfAbsent('content-type', () => 'application/json'),
              body: jsonEncode({'query': query, 'variables': variables}))
          .then((res) {
        final body = jsonDecode(res.body);
        if ((body['errors'] as List)?.isNotEmpty ?? false) {
          throw GQLError._getErrors(body['errors']);
        }
        return GQLResponse(data: body['data']);
      });
    } catch (e) {
      rethrow;
    }
  }

  /// GQL Mutation using the Dart Http package
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
  /// import 'package:simple_gql/simple_gql.dart';
  ///
  /// final response = await GQLClient(
  ///   url: 'https://your_gql_endpoint',
  /// ).mutation(
  ///   mutation: r'''
  ///     mutation CreateMessage($input: String) {
  ///       createMessage(input: $input) {
  ///         id
  ///       }
  ///     }
  ///   ''',
  ///   variables: { 'input': 'message' }
  /// );
  /// ```
  Future<GQLResponse> mutation(
      {@required String mutation,
      Map<String, dynamic> variables,
      Map<String, String> headers}) async {
    try {
      return await post(Uri.parse(endpoint),
              headers: (headers ?? _headers)
                ..putIfAbsent('content-type', () => 'application/json')
                ..putIfAbsent('accept', () => 'application/json'),
              body: jsonEncode({'query': mutation, 'variables': variables}))
          .then((res) {
        final body = jsonDecode(res.body);
        if ((body['errors'] as List)?.isNotEmpty ?? false) {
          throw GQLError._getErrors(body['errors']);
        }
        return GQLResponse(data: body['data']);
      });
    } catch (e) {
      rethrow;
    }
  }
}
