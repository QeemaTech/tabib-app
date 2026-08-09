import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/chat/data/data_source/chat_data_source.dart';
import 'package:tabib_app/features/chat/data/mapper/consultations_mapper.dart';
import 'package:tabib_app/features/chat/data/models/response/consultations_response.dart';
import 'package:tabib_app/features/chat/domain/entities/consultation_entity.dart';
import 'package:tabib_app/features/chat/domain/repo/chat_repo.dart';

@LazySingleton(as: ChatRepo)
class ChatRepoImpl implements ChatRepo {
  final ChatDataSource dataSource;

  ChatRepoImpl(this.dataSource);

  @override
  Future<Result<List<ConsultationEntity>>> getConsultations() async {
    final response = await dataSource.getConsultations();
    switch (response) {
      case Success<ConsultationsResponse>():
        return Success(response.data.toEntityList());
      case Failure<ConsultationsResponse>():
        return Failure(response.errorMessage);
    }
  }
}
