import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message; // Добавлено поле для сообщения об ошибке

  Failure(this.message); // Конструктор для установки сообщения об ошибке

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure([String message = 'Server Failure']) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure([String message = 'Cache Failure']) : super(message);
}
