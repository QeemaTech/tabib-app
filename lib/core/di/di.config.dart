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

import '../../features/appointments/data/data_source/appointments_data_source.dart'
    as _i275;
import '../../features/appointments/data/data_source/appointments_data_source_impl.dart'
    as _i47;
import '../../features/appointments/data/repo/appointments_repo_impl.dart'
    as _i611;
import '../../features/appointments/domain/repo/appointments_repo.dart'
    as _i201;
import '../../features/appointments/presentation/view_model/appointments_view_model.dart'
    as _i486;
import '../../features/auth/data/data_source/doctor_onboarding_data_source.dart'
    as _i577;
import '../../features/auth/data/data_source/doctor_onboarding_data_source_impl.dart'
    as _i651;
import '../../features/auth/data/data_source/patient_health_profile_data_source.dart'
    as _i659;
import '../../features/auth/data/data_source/patient_health_profile_data_source_impl.dart'
    as _i362;
import '../../features/auth/data/data_source/remote_data_source.dart' as _i217;
import '../../features/auth/data/data_source/remote_data_source_impl.dart'
    as _i52;
import '../../features/auth/data/repo/auth_repo_impl.dart' as _i984;
import '../../features/auth/data/repo/doctor_onboarding_repo_impl.dart'
    as _i291;
import '../../features/auth/data/repo/patient_health_profile_repo_impl.dart'
    as _i49;
import '../../features/auth/domain/repo/auth_repo.dart' as _i170;
import '../../features/auth/domain/repo/doctor_onboarding_repo.dart' as _i313;
import '../../features/auth/domain/repo/patient_health_profile_repo.dart'
    as _i541;
import '../../features/auth/presentation/view_model/auth_view_model.dart'
    as _i1025;
import '../../features/auth/presentation/view_model/doc/complete_doc_profile_cubit.dart'
    as _i380;
import '../../features/auth/presentation/view_model/patient/complete_patient_profile_view_model.dart'
    as _i765;
import '../../features/home/data/data_source/doctor_dashboard_data_source.dart'
    as _i25;
import '../../features/home/data/data_source/doctor_dashboard_data_source_impl.dart'
    as _i204;
import '../../features/home/data/data_source/doctor_details_data_source.dart'
    as _i10;
import '../../features/home/data/data_source/doctor_details_data_source_impl.dart'
    as _i276;
import '../../features/home/data/data_source/patient_home_data_source.dart'
    as _i862;
import '../../features/home/data/data_source/patient_home_data_source_impl.dart'
    as _i443;
import '../../features/home/data/data_source/search_doctors_data_source.dart'
    as _i960;
import '../../features/home/data/data_source/search_doctors_data_source_impl.dart'
    as _i556;
import '../../features/home/data/repo/doctor_dashboard_repo_impl.dart' as _i157;
import '../../features/home/data/repo/doctor_details_repo_impl.dart' as _i1007;
import '../../features/home/data/repo/patient_home_repo_impl.dart' as _i455;
import '../../features/home/data/repo/search_doctors_repo_impl.dart' as _i232;
import '../../features/home/domain/repo/doctor_dashboard_repo.dart' as _i845;
import '../../features/home/domain/repo/doctor_details_repo.dart' as _i806;
import '../../features/home/domain/repo/patient_home_repo.dart' as _i845;
import '../../features/home/domain/repo/search_doctors_repo.dart' as _i824;
import '../../features/home/presentation/view_model/doctor_dashboard_view_model.dart'
    as _i720;
import '../../features/home/presentation/view_model/doctor_details_view_model.dart'
    as _i93;
import '../../features/home/presentation/view_model/patient_home_view_model.dart'
    as _i241;
import '../../features/home/presentation/view_model/search_doctors_view_model.dart'
    as _i53;
import '../../features/layout/view_model/layout_view_model.dart' as _i566;
import '../../features/profile/data/data_source/doctor_profile_data_source.dart'
    as _i566;
import '../../features/profile/data/data_source/doctor_profile_data_source_impl.dart'
    as _i344;
import '../../features/profile/data/data_source/patient_profile_data_source.dart'
    as _i311;
import '../../features/profile/data/data_source/patient_profile_data_source_impl.dart'
    as _i762;
import '../../features/profile/data/repo/doctor_profile_repo_impl.dart'
    as _i1050;
import '../../features/profile/data/repo/patient_profile_repo_impl.dart'
    as _i544;
import '../../features/profile/domain/repo/doctor_profile_repo.dart' as _i64;
import '../../features/profile/domain/repo/patient_profile_repo.dart' as _i407;
import '../../features/profile/presentation/view_model/doctor_profile_view_model.dart'
    as _i162;
import '../../features/profile/presentation/view_model/patient_profile_view_model.dart'
    as _i369;
import '../../features/wallet/data/data_source/wallet_data_source.dart'
    as _i914;
import '../../features/wallet/data/data_source/wallet_data_source_impl.dart'
    as _i474;
import '../../features/wallet/data/repo/wallet_repo_impl.dart' as _i925;
import '../../features/wallet/domain/repo/wallet_repo.dart' as _i413;
import '../../features/wallet/presentation/view_model/wallet_view_model.dart'
    as _i226;
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
    gh.lazySingleton<_i25.DoctorDashboardDataSource>(
      () => _i204.DoctorDashboardDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i10.DoctorDetailsDataSource>(
      () => _i276.DoctorDetailsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i275.AppointmentsDataSource>(
      () => _i47.AppointmentsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i577.DoctorOnboardingDataSource>(
      () => _i651.DoctorOnboardingDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i862.PatientHomeDataSource>(
      () => _i443.PatientHomeDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i806.DoctorDetailsRepo>(
      () => _i1007.DoctorDetailsRepoImpl(gh<_i10.DoctorDetailsDataSource>()),
    );
    gh.factory<_i93.DoctorDetailsViewModel>(
      () => _i93.DoctorDetailsViewModel(
        doctorDetailsRepo: gh<_i806.DoctorDetailsRepo>(),
      ),
    );
    gh.lazySingleton<_i311.PatientProfileDataSource>(
      () => _i762.PatientProfileDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i407.PatientProfileRepo>(
      () => _i544.PatientProfileRepoImpl(gh<_i311.PatientProfileDataSource>()),
    );
    gh.lazySingleton<_i566.DoctorProfileDataSource>(
      () => _i344.DoctorProfileDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i845.DoctorDashboardRepo>(
      () => _i157.DoctorDashboardRepoImpl(gh<_i25.DoctorDashboardDataSource>()),
    );
    gh.lazySingleton<_i217.RemoteDataSource>(
      () => _i52.RemoteDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i960.SearchDoctorsDataSource>(
      () => _i556.SearchDoctorsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i659.PatientHealthProfileDataSource>(
      () => _i362.PatientHealthProfileDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i914.WalletDataSource>(
      () => _i474.WalletDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.factory<_i720.DoctorDashboardViewModel>(
      () => _i720.DoctorDashboardViewModel(
        doctorDashboardRepo: gh<_i845.DoctorDashboardRepo>(),
      ),
    );
    gh.lazySingleton<_i541.PatientHealthProfileRepo>(
      () => _i49.PatientHealthProfileRepoImpl(
        gh<_i659.PatientHealthProfileDataSource>(),
      ),
    );
    gh.lazySingleton<_i413.WalletRepo>(
      () => _i925.WalletRepoImpl(gh<_i914.WalletDataSource>()),
    );
    gh.lazySingleton<_i824.SearchDoctorsRepo>(
      () => _i232.SearchDoctorsRepoImpl(gh<_i960.SearchDoctorsDataSource>()),
    );
    gh.lazySingleton<_i201.AppointmentsRepo>(
      () => _i611.AppointmentsRepoImpl(gh<_i275.AppointmentsDataSource>()),
    );
    gh.factory<_i226.WalletViewModel>(
      () => _i226.WalletViewModel(walletRepo: gh<_i413.WalletRepo>()),
    );
    gh.lazySingleton<_i64.DoctorProfileRepo>(
      () => _i1050.DoctorProfileRepoImpl(gh<_i566.DoctorProfileDataSource>()),
    );
    gh.lazySingleton<_i170.AuthRepo>(
      () => _i984.AuthRepoImpl(gh<_i217.RemoteDataSource>()),
    );
    gh.lazySingleton<_i313.DoctorOnboardingRepo>(
      () => _i291.DoctorOnboardingRepoImpl(
        gh<_i577.DoctorOnboardingDataSource>(),
      ),
    );
    gh.factory<_i380.CompleteDocProfileCubit>(
      () => _i380.CompleteDocProfileCubit(
        gh<_i772.ImagePickerServices>(),
        gh<_i313.DoctorOnboardingRepo>(),
      ),
    );
    gh.factory<_i53.SearchDoctorsViewModel>(
      () => _i53.SearchDoctorsViewModel(
        searchDoctorsRepo: gh<_i824.SearchDoctorsRepo>(),
      ),
    );
    gh.lazySingleton<_i845.PatientHomeRepo>(
      () => _i455.PatientHomeRepoImpl(gh<_i862.PatientHomeDataSource>()),
    );
    gh.factory<_i369.PatientProfileViewModel>(
      () => _i369.PatientProfileViewModel(
        patientProfileRepo: gh<_i407.PatientProfileRepo>(),
      ),
    );
    gh.factory<_i162.DoctorProfileViewModel>(
      () => _i162.DoctorProfileViewModel(
        doctorProfileRepo: gh<_i64.DoctorProfileRepo>(),
      ),
    );
    gh.factory<_i765.CompletePatientProfileViewModel>(
      () => _i765.CompletePatientProfileViewModel(
        imagePicker: gh<_i772.ImagePickerServices>(),
        patientHealthProfileRepo: gh<_i541.PatientHealthProfileRepo>(),
      ),
    );
    gh.factory<_i486.AppointmentsViewModel>(
      () => _i486.AppointmentsViewModel(
        appointmentsRepo: gh<_i201.AppointmentsRepo>(),
      ),
    );
    gh.factory<_i1025.AuthViewModel>(
      () => _i1025.AuthViewModel(gh<_i170.AuthRepo>()),
    );
    gh.factory<_i241.PatientHomeViewModel>(
      () => _i241.PatientHomeViewModel(
        patientHomeRepo: gh<_i845.PatientHomeRepo>(),
      ),
    );
    return this;
  }
}

class _$ApiModule extends _i0.ApiModule {}
