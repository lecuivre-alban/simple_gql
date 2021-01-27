/*
 * File Created: 2020-05-27 16:11
 * Author: Alban LECUIVRE
 * Copyright - 2020 Alban LECUIVRE
 */

part of simple_gql;

class GQLResponse {
  final dynamic _data;

  GQLResponse({@required dynamic data}) : _data = data;

  bool get hasData => _data != null;
  dynamic get data => _data;

  @override
  String toString() => 'GQLRESPONSE:\n\tdata:$data';
}

class GQLError {
  final String message;
  final String code;

  GQLError({this.code, this.message});

  static List<GQLError> _getErrors(List<dynamic> err) {
    if (err == null) return null;
    if (err.isEmpty) return [];
    return err.map((e) {
      try {
        return GQLError(code: e['extensions']['code'], message: e['message']);
      } catch (_) {
        return GQLError(code: null, message: null);
      }
    }).toList();
  }

  @override
  String toString() => 'GQLERROR:\n\tcode:$code\n\tmessage:$message';
}

// compatibility for old code
@deprecated
class GQLMsg {
  final dynamic body;

  GQLMsg(this.body);

  dynamic get data => body['data'];
  List<GQLError> get errors => GQLError._getErrors(body['errors']);
  GQLError get error => errors.first;
  bool get hasData => body['data'] != null;
  bool get hasErrors => (errors ?? []).isNotEmpty;
}
