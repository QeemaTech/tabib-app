import 'package:equatable/equatable.dart';

class HealthProfileFileEntity extends Equatable {
  final String id;
  final String fileName;
  final String fileUrl;
  final String fileType;
  final int fileSize;
  final String createdAt;

  const HealthProfileFileEntity({
    required this.id,
    required this.fileName,
    required this.fileUrl,
    required this.fileType,
    required this.fileSize,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    fileName,
    fileUrl,
    fileType,
    fileSize,
    createdAt,
  ];
}
