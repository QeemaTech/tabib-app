import 'package:equatable/equatable.dart';

class InvoiceFileEntity extends Equatable {
  final List<int> bytes;
  final String fileName;

  const InvoiceFileEntity({required this.bytes, required this.fileName});

  @override
  List<Object?> get props => [bytes, fileName];
}
