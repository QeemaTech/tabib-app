// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:talker_dio_logger/talker_dio_logger.dart' as _i52;

import '../../features/auth/data/data_source/patient_health_profile_data_source.dart'
    as _i659;
import '../../features/auth/data/data_source/patient_health_profile_data_source_impl.dart'
    as _i362;
import '../../features/auth/data/data_source/remote_data_source.dart' as _i217;
import '../../features/auth/data/data_source/remote_data_source_impl.dart'
    as _i52;
import '../../features/auth/data/repo/auth_repo_impl.dart' as _i984;
import '../../features/auth/data/repo/patient_health_profile_repo_impl.dart'
    as _i49;
import '../../features/auth/domain/repo/auth_repo.dart' as _i170;
import '../../features/auth/domain/repo/patient_health_profile_repo.dart'
    as _i541;
import '../../features/auth/presentation/view_model/auth_view_model.dart'
    as _i1025;
import '../../features/auth/presentation/view_model/doc/complete_doc_profile_cubit.dart'
    as _i380;
import '../../features/auth/presentation/view_model/patient/complete_patient_profile_view_model.dart'
    as _i765;
import '../../features/layout/view_model/layout_view_model.dart' as _i566;
import '../api/api_client.dart' as _i277;
import '../api/api_module.dart' as _i0;
import '../app_services/image_picker_services.dart' as _i772;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiModule = _$ApiModule();
    gh.factory<_i772.ImagePickerServices>(() => _i772.ImagePickerServices());
    gh.factory<_i566.LayoutViewModel>(() => _i566.LayoutViewModel());
    gh.lazySingleton<_i361.BaseOptions>(() => apiModule.providerOption());
    gh.lazySingleton<_i52.TalkerDioLogger>(() => apiModule.provideLogger());
    gh.lazySingleton<_i361.Dio>(
      () => apiModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i52.TalkerDioLogger>(),
      ),
    );
    gh.lazySingleton<_i277.ApiClient>(
      () => apiModule.provideApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i380.CompleteDocProfileCubit>(
      () => _i380.CompleteDocProfileCubit(gh<_i772.ImagePickerServices>()),
    );
    gh.lazySingleton<_i217.RemoteDataSource>(
      () => _i52.RemoteDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i659.PatientHealthProfileDataSource>(
      () => _i362.PatientHealthProfileDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i541.PatientHealthProfileRepo>(
      () => _i49.PatientHealthProfileRepoImpl(
        gh<_i659.PatientHealthProfileDataSource>(),
      ),
    );
    gh.lazySingleton<_i170.AuthRepo>(
      () => _i984.AuthRepoImpl(gh<_i217.RemoteDataSource>()),
    );
    gh.factory<_i765.CompletePatientProfileViewModel>(
      () => _i765.CompletePatientProfileViewModel(
        imagePicker: gh<_i772.ImagePickerServices>(),
        patientHealthProfileRepo: gh<_i541.PatientHealthProfileRepo>(),
      ),
    );
    gh.factory<_i1025.AuthViewModel>(
      () => _i1025.AuthViewModel(gh<_i170.AuthRepo>()),
    );
    return this;
  }
}

class _$ApiModule extends _i0.ApiModule {}
