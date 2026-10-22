import 'package:equatable/equatable.dart';

class MarkAllReadEntity extends Equatable {
  final int updated;

  const MarkAllReadEntity({required this.updated});

  @override
  List<Object?> get props => [updated];
}
