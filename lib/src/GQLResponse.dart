import 'package:meta/meta.dart';

class GQLResponse {
  final dynamic _data;
  final List<GQLError> _errors;

  GQLResponse({@required  dynamic data, @required List<dynamic> errors}): _data=data, _errors=_getErrors(errors);

  bool get hasErrors => _errors?.isNotEmpty ?? false;
  bool get hasData => _data != null;

  dynamic get data => _data;
  List<GQLError> get errors => _errors;
  GQLError get error => _errors?.first;

  static List<GQLError> _getErrors(List<dynamic> err) {
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
}

class GQLError {
  final String message;
  final String code;

  GQLError({this.code, this.message});
}