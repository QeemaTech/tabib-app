import 'package:equatable/equatable.dart';

sealed class Result<T> extends Equatable {
 const Result();

  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(String errorMessage) = Failure<T>;

  R when<R>({
    required R Function(T data) success,
    required R Function(String errorMessage) failure,
  }) {
    return switch (this) {
      Success<T>(:final data) => success(data),
      Failure<T>(:final errorMessage) => failure(errorMessage),
    };
  }
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
  @override
 
  @override
  List<Object?> get props => [data];
  

}

class Failure<T> extends Result<T> {
  final String errorMessage;
  const Failure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
  

}


