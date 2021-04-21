/*
 * File Created: 2020-05-27 16:11
 * Author: Alban LECUIVRE
 * Copyright - 2020 Alban LECUIVRE
 */

part of simple_gql;

class GQLResponse {
  final dynamic _data;
  final Response _httpResponse;

  GQLResponse({
    required  dynamic data,
    required Response httpResponse
  }): _data=data, _httpResponse=httpResponse;

  bool get hasData => _data != null;
  dynamic get data => _data;
  Response get httpResponse => _httpResponse;

  @override
  String toString() => 'GQLRESPONSE:\n\tdata:$data';

}

class GQLError {
  final String? message;
  final String? code;

  GQLError({this.code, this.message});

  static List<GQLError>? _getErrors(List<dynamic>? err) {
    if(err == null) return null;
    if(err.isEmpty) return [];
    return err.map(
      (e){
        try{
          return GQLError(code: e['extensions']['code'], message: e['message']);
        }catch(_){
          return GQLError(code: null, message: null);
        }         
      }
    ).toList();
  }

  @override
  String toString() => 'GQLERROR:\n\tcode:$code\n\tmessage:$message';
}