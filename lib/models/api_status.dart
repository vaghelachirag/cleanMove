import 'package:sealed_annotations/sealed_annotations.dart';

@Sealed()
class Result<T> {}

class Loading<T> implements Result<T> {}

class Success<T> implements Result<T> {
  final T data;
  final String? message;
  Success({required this.data, this.message});
}

class Failure<T> extends Result<T> {
  final int? statusCode;
  final String message;

  Failure({this.statusCode, required this.message});
}