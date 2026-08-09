import 'package:injectable/injectable.dart';
import 'package:tabib_app/core/api/api_client.dart';
import 'package:tabib_app/core/error_handling/execute_api.dart';
import 'package:tabib_app/core/error_handling/result.dart';
import 'package:tabib_app/features/chat/data/data_source/chat_data_source.dart';
import 'package:tabib_app/features/chat/data/models/response/consultations_response.dart';

@LazySingleton(as: ChatDataSource)
class ChatDataSourceImpl implements ChatDataSource {
  final ApiClient apiClient;

  ChatDataSourceImpl(this.apiClient);

  @override
  Future<Result<ConsultationsResponse>> getConsultations() {
    return executeApi(() => apiClient.getConsultations());
  }
}
