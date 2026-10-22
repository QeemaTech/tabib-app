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

import '../../features/doctor_flow/auth/data/data_source/doctor_onboarding_data_source.dart'
    as _i535;
import '../../features/doctor_flow/auth/data/data_source/doctor_onboarding_data_source_impl.dart'
    as _i365;
import '../../features/doctor_flow/auth/data/data_source/remote_data_source.dart'
    as _i481;
import '../../features/doctor_flow/auth/data/data_source/remote_data_source_impl.dart'
    as _i962;
import '../../features/doctor_flow/auth/data/repo/auth_repo_impl.dart'
    as _i1026;
import '../../features/doctor_flow/auth/data/repo/doctor_onboarding_repo_impl.dart'
    as _i54;
import '../../features/doctor_flow/auth/domain/repo/auth_repo.dart' as _i53;
import '../../features/doctor_flow/auth/domain/repo/doctor_onboarding_repo.dart'
    as _i286;
import '../../features/doctor_flow/auth/presentation/view_model/auth_view_model.dart'
    as _i891;
import '../../features/doctor_flow/auth/presentation/view_model/doc/complete_doc_profile_cubit.dart'
    as _i551;
import '../../features/doctor_flow/calls/data/data_source/calls_data_source.dart'
    as _i536;
import '../../features/doctor_flow/calls/data/data_source/calls_data_source_impl.dart'
    as _i464;
import '../../features/doctor_flow/calls/data/repo/calls_repo_impl.dart'
    as _i879;
import '../../features/doctor_flow/calls/domain/repo/calls_repo.dart' as _i600;
import '../../features/doctor_flow/calls/presentation/view_model/video_call_view_model.dart'
    as _i323;
import '../../features/doctor_flow/chat/data/data_source/chat_data_source.dart'
    as _i982;
import '../../features/doctor_flow/chat/data/data_source/chat_data_source_impl.dart'
    as _i462;
import '../../features/doctor_flow/chat/data/repo/chat_repo_impl.dart' as _i274;
import '../../features/doctor_flow/chat/domain/repo/chat_repo.dart' as _i43;
import '../../features/doctor_flow/chat/presentation/view_model/chat_details_view_model.dart'
    as _i853;
import '../../features/doctor_flow/chat/presentation/view_model/chat_list_view_model.dart'
    as _i265;
import '../../features/doctor_flow/chat/presentation/view_model/start_consultation_view_model.dart'
    as _i685;
import '../../features/doctor_flow/home/data/data_source/doctor_dashboard_data_source.dart'
    as _i374;
import '../../features/doctor_flow/home/data/data_source/doctor_dashboard_data_source_impl.dart'
    as _i603;
import '../../features/doctor_flow/home/data/repo/doctor_dashboard_repo_impl.dart'
    as _i933;
import '../../features/doctor_flow/home/domain/repo/doctor_dashboard_repo.dart'
    as _i523;
import '../../features/doctor_flow/home/presentation/view_model/doctor_dashboard_view_model.dart'
    as _i537;
import '../../features/doctor_flow/notification/data/data_source/notifications_data_source.dart'
    as _i405;
import '../../features/doctor_flow/notification/data/data_source/notifications_data_source_impl.dart'
    as _i974;
import '../../features/doctor_flow/notification/data/repo/notifications_repo_impl.dart'
    as _i884;
import '../../features/doctor_flow/notification/domain/repo/notifications_repo.dart'
    as _i95;
import '../../features/doctor_flow/notification/presentation/view_model/notifications_view_model.dart'
    as _i129;
import '../../features/doctor_flow/patients/data/data_source/doctor_patients_data_source.dart'
    as _i966;
import '../../features/doctor_flow/patients/data/data_source/doctor_patients_data_source_impl.dart'
    as _i118;
import '../../features/doctor_flow/patients/data/data_source/patient_file_data_source.dart'
    as _i743;
import '../../features/doctor_flow/patients/data/data_source/patient_file_data_source_impl.dart'
    as _i15;
import '../../features/doctor_flow/patients/data/repo/doctor_patients_repo_impl.dart'
    as _i922;
import '../../features/doctor_flow/patients/data/repo/patient_file_repo_impl.dart'
    as _i555;
import '../../features/doctor_flow/patients/domain/repo/doctor_patients_repo.dart'
    as _i68;
import '../../features/doctor_flow/patients/domain/repo/patient_file_repo.dart'
    as _i175;
import '../../features/doctor_flow/patients/presentation/view_model/doctor_patients_view_model.dart'
    as _i647;
import '../../features/doctor_flow/patients/presentation/view_model/patient_file_view_model.dart'
    as _i702;
import '../../features/doctor_flow/profile/data/data_source/doctor_profile_data_source.dart'
    as _i517;
import '../../features/doctor_flow/profile/data/data_source/doctor_profile_data_source_impl.dart'
    as _i898;
import '../../features/doctor_flow/profile/data/repo/doctor_profile_repo_impl.dart'
    as _i961;
import '../../features/doctor_flow/profile/domain/repo/doctor_profile_repo.dart'
    as _i114;
import '../../features/doctor_flow/profile/presentation/view_model/doctor_profile_view_model.dart'
    as _i457;
import '../../features/doctor_flow/reservations/data/data_source/doctor_appointments_data_source.dart'
    as _i739;
import '../../features/doctor_flow/reservations/data/data_source/doctor_appointments_data_source_impl.dart'
    as _i404;
import '../../features/doctor_flow/reservations/data/repo/doctor_appointments_repo_impl.dart'
    as _i461;
import '../../features/doctor_flow/reservations/domain/repo/doctor_appointments_repo.dart'
    as _i838;
import '../../features/doctor_flow/reservations/presentation/view_model/create_report_view_model.dart'
    as _i854;
import '../../features/doctor_flow/reservations/presentation/view_model/doctor_appointment_details_view_model.dart'
    as _i807;
import '../../features/doctor_flow/reservations/presentation/view_model/doctor_appointments_view_model.dart'
    as _i483;
import '../../features/doctor_flow/schedule/data/data_source/doctor_schedule_data_source.dart'
    as _i276;
import '../../features/doctor_flow/schedule/data/data_source/doctor_schedule_data_source_impl.dart'
    as _i576;
import '../../features/doctor_flow/schedule/data/repo/doctor_schedule_repo_impl.dart'
    as _i437;
import '../../features/doctor_flow/schedule/domain/repo/doctor_schedule_repo.dart'
    as _i1038;
import '../../features/doctor_flow/schedule/presentation/view_model/doctor_schedule_view_model.dart'
    as _i48;
import '../../features/doctor_flow/shell/doctor_layout_view_model.dart'
    as _i588;
import '../../features/doctor_flow/wallet/data/data_source/wallet_data_source.dart'
    as _i623;
import '../../features/doctor_flow/wallet/data/data_source/wallet_data_source_impl.dart'
    as _i168;
import '../../features/doctor_flow/wallet/data/repo/wallet_repo_impl.dart'
    as _i664;
import '../../features/doctor_flow/wallet/domain/repo/wallet_repo.dart'
    as _i882;
import '../../features/doctor_flow/wallet/presentation/view_model/doctor_wallet_view_model.dart'
    as _i381;
import '../../features/doctor_flow/wallet/presentation/view_model/doctor_withdraw_view_model.dart'
    as _i663;
import '../../features/doctor_flow/wallet/presentation/view_model/doctor_withdrawal_details_view_model.dart'
    as _i927;
import '../../features/patient_flow/appointments/data/data_source/appointments_data_source.dart'
    as _i127;
import '../../features/patient_flow/appointments/data/data_source/appointments_data_source_impl.dart'
    as _i151;
import '../../features/patient_flow/appointments/data/repo/appointments_repo_impl.dart'
    as _i345;
import '../../features/patient_flow/appointments/domain/repo/appointments_repo.dart'
    as _i798;
import '../../features/patient_flow/appointments/presentation/view_model/appointment_details_view_model.dart'
    as _i7;
import '../../features/patient_flow/appointments/presentation/view_model/appointments_view_model.dart'
    as _i671;
import '../../features/patient_flow/appointments/presentation/view_model/confirm_payment_view_model.dart'
    as _i802;
import '../../features/patient_flow/appointments/presentation/view_model/patient_invoices_view_model.dart'
    as _i646;
import '../../features/patient_flow/appointments/presentation/view_model/payment_success_view_model.dart'
    as _i444;
import '../../features/patient_flow/auth/data/data_source/doctor_onboarding_data_source.dart'
    as _i30;
import '../../features/patient_flow/auth/data/data_source/doctor_onboarding_data_source_impl.dart'
    as _i482;
import '../../features/patient_flow/auth/data/data_source/patient_health_profile_data_source.dart'
    as _i123;
import '../../features/patient_flow/auth/data/data_source/patient_health_profile_data_source_impl.dart'
    as _i207;
import '../../features/patient_flow/auth/data/data_source/remote_data_source.dart'
    as _i108;
import '../../features/patient_flow/auth/data/data_source/remote_data_source_impl.dart'
    as _i94;
import '../../features/patient_flow/auth/data/repo/auth_repo_impl.dart'
    as _i288;
import '../../features/patient_flow/auth/data/repo/doctor_onboarding_repo_impl.dart'
    as _i327;
import '../../features/patient_flow/auth/data/repo/patient_health_profile_repo_impl.dart'
    as _i947;
import '../../features/patient_flow/auth/domain/repo/auth_repo.dart' as _i311;
import '../../features/patient_flow/auth/domain/repo/doctor_onboarding_repo.dart'
    as _i386;
import '../../features/patient_flow/auth/domain/repo/patient_health_profile_repo.dart'
    as _i570;
import '../../features/patient_flow/auth/presentation/view_model/auth_view_model.dart'
    as _i851;
import '../../features/patient_flow/auth/presentation/view_model/patient/complete_patient_profile_view_model.dart'
    as _i669;
import '../../features/patient_flow/calls/data/data_source/calls_data_source.dart'
    as _i128;
import '../../features/patient_flow/calls/data/data_source/calls_data_source_impl.dart'
    as _i8;
import '../../features/patient_flow/calls/data/repo/calls_repo_impl.dart'
    as _i779;
import '../../features/patient_flow/calls/domain/repo/calls_repo.dart' as _i871;
import '../../features/patient_flow/calls/presentation/view_model/video_call_view_model.dart'
    as _i392;
import '../../features/patient_flow/chat/data/data_source/chat_data_source.dart'
    as _i993;
import '../../features/patient_flow/chat/data/data_source/chat_data_source_impl.dart'
    as _i941;
import '../../features/patient_flow/chat/data/repo/chat_repo_impl.dart'
    as _i544;
import '../../features/patient_flow/chat/domain/repo/chat_repo.dart' as _i692;
import '../../features/patient_flow/chat/presentation/view_model/chat_details_view_model.dart'
    as _i273;
import '../../features/patient_flow/chat/presentation/view_model/chat_list_view_model.dart'
    as _i586;
import '../../features/patient_flow/chat/presentation/view_model/start_consultation_view_model.dart'
    as _i873;
import '../../features/patient_flow/home/data/data_source/doctor_details_data_source.dart'
    as _i1029;
import '../../features/patient_flow/home/data/data_source/doctor_details_data_source_impl.dart'
    as _i279;
import '../../features/patient_flow/home/data/data_source/patient_home_data_source.dart'
    as _i317;
import '../../features/patient_flow/home/data/data_source/patient_home_data_source_impl.dart'
    as _i1056;
import '../../features/patient_flow/home/data/data_source/search_doctors_data_source.dart'
    as _i487;
import '../../features/patient_flow/home/data/data_source/search_doctors_data_source_impl.dart'
    as _i834;
import '../../features/patient_flow/home/data/repo/doctor_details_repo_impl.dart'
    as _i363;
import '../../features/patient_flow/home/data/repo/patient_home_repo_impl.dart'
    as _i450;
import '../../features/patient_flow/home/data/repo/search_doctors_repo_impl.dart'
    as _i227;
import '../../features/patient_flow/home/domain/repo/doctor_details_repo.dart'
    as _i307;
import '../../features/patient_flow/home/domain/repo/patient_home_repo.dart'
    as _i181;
import '../../features/patient_flow/home/domain/repo/search_doctors_repo.dart'
    as _i290;
import '../../features/patient_flow/home/presentation/view_model/doctor_details_view_model.dart'
    as _i399;
import '../../features/patient_flow/home/presentation/view_model/patient_home_view_model.dart'
    as _i119;
import '../../features/patient_flow/home/presentation/view_model/search_doctors_view_model.dart'
    as _i150;
import '../../features/patient_flow/home/presentation/view_model/specialties_view_model.dart'
    as _i918;
import '../../features/patient_flow/notification/data/data_source/notifications_data_source.dart'
    as _i319;
import '../../features/patient_flow/notification/data/data_source/notifications_data_source_impl.dart'
    as _i373;
import '../../features/patient_flow/notification/data/repo/notifications_repo_impl.dart'
    as _i855;
import '../../features/patient_flow/notification/domain/repo/notifications_repo.dart'
    as _i105;
import '../../features/patient_flow/notification/presentation/view_model/notifications_view_model.dart'
    as _i339;
import '../../features/patient_flow/profile/data/data_source/patient_profile_data_source.dart'
    as _i744;
import '../../features/patient_flow/profile/data/data_source/patient_profile_data_source_impl.dart'
    as _i862;
import '../../features/patient_flow/profile/data/repo/patient_profile_repo_impl.dart'
    as _i991;
import '../../features/patient_flow/profile/domain/repo/patient_profile_repo.dart'
    as _i320;
import '../../features/patient_flow/profile/presentation/view_model/patient_profile_view_model.dart'
    as _i863;
import '../../features/patient_flow/records/data/data_source/records_data_source.dart'
    as _i113;
import '../../features/patient_flow/records/data/data_source/records_data_source_impl.dart'
    as _i1030;
import '../../features/patient_flow/records/data/repo/records_repo_impl.dart'
    as _i622;
import '../../features/patient_flow/records/domain/repo/records_repo.dart'
    as _i475;
import '../../features/patient_flow/records/presentation/view_model/prescription_details_view_model.dart'
    as _i9;
import '../../features/patient_flow/records/presentation/view_model/records_view_model.dart'
    as _i139;
import '../../features/patient_flow/records/presentation/view_model/report_details_view_model.dart'
    as _i453;
import '../../features/patient_flow/shell/patient_layout_view_model.dart'
    as _i748;
import '../../features/patient_flow/wallet/data/data_source/wallet_data_source.dart'
    as _i503;
import '../../features/patient_flow/wallet/data/data_source/wallet_data_source_impl.dart'
    as _i470;
import '../../features/patient_flow/wallet/data/repo/wallet_repo_impl.dart'
    as _i1014;
import '../../features/patient_flow/wallet/domain/repo/wallet_repo.dart'
    as _i896;
import '../../features/patient_flow/wallet/presentation/view_model/wallet_view_model.dart'
    as _i801;
import '../api/api_client.dart' as _i277;
import '../api/api_module.dart' as _i0;
import '../app_services/agora_rtc_service.dart' as _i639;
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
    gh.factory<_i588.DoctorLayoutViewModel>(
      () => _i588.DoctorLayoutViewModel(),
    );
    gh.factory<_i748.PatientLayoutViewModel>(
      () => _i748.PatientLayoutViewModel(),
    );
    gh.lazySingleton<_i361.BaseOptions>(() => apiModule.providerOption());
    gh.lazySingleton<_i52.TalkerDioLogger>(() => apiModule.provideLogger());
    gh.lazySingleton<_i639.AgoraRtcService>(() => _i639.AgoraRtcService());
    gh.lazySingleton<_i361.Dio>(
      () => apiModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i52.TalkerDioLogger>(),
      ),
    );
    gh.lazySingleton<_i277.ApiClient>(
      () => apiModule.provideApiClient(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i481.DoctorRemoteDataSource>(
      () => _i962.DoctorRemoteDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i993.PatientChatDataSource>(
      () => _i941.PatientChatDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i739.DoctorAppointmentsDataSource>(
      () => _i404.DoctorAppointmentsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i319.PatientNotificationsDataSource>(
      () => _i373.PatientNotificationsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i317.PatientHomeDataSource>(
      () => _i1056.PatientHomeDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i536.DoctorCallsDataSource>(
      () => _i464.DoctorCallsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i113.RecordsDataSource>(
      () => _i1030.RecordsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i744.PatientProfileDataSource>(
      () => _i862.PatientProfileDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i1029.DoctorDetailsDataSource>(
      () => _i279.DoctorDetailsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i475.RecordsRepo>(
      () => _i622.RecordsRepoImpl(gh<_i113.RecordsDataSource>()),
    );
    gh.lazySingleton<_i966.DoctorPatientsDataSource>(
      () => _i118.DoctorPatientsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i108.PatientRemoteDataSource>(
      () => _i94.PatientRemoteDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i128.PatientCallsDataSource>(
      () => _i8.PatientCallsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i623.DoctorWalletDataSource>(
      () => _i168.DoctorWalletDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i123.PatientHealthProfileDataSource>(
      () => _i207.PatientHealthProfileDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i53.DoctorAuthRepo>(
      () => _i1026.DoctorAuthRepoImpl(gh<_i481.DoctorRemoteDataSource>()),
    );
    gh.lazySingleton<_i871.PatientCallsRepo>(
      () => _i779.PatientCallsRepoImpl(gh<_i128.PatientCallsDataSource>()),
    );
    gh.lazySingleton<_i838.DoctorAppointmentsRepo>(
      () => _i461.DoctorAppointmentsRepoImpl(
        gh<_i739.DoctorAppointmentsDataSource>(),
      ),
    );
    gh.lazySingleton<_i127.AppointmentsDataSource>(
      () => _i151.AppointmentsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i374.DoctorDashboardDataSource>(
      () => _i603.DoctorDashboardDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i882.DoctorWalletRepo>(
      () => _i664.DoctorWalletRepoImpl(gh<_i623.DoctorWalletDataSource>()),
    );
    gh.lazySingleton<_i743.PatientFileDataSource>(
      () => _i15.PatientFileDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i405.DoctorNotificationsDataSource>(
      () => _i974.DoctorNotificationsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i276.DoctorScheduleDataSource>(
      () => _i576.DoctorScheduleDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i30.PatientCatalogDataSource>(
      () => _i482.PatientCatalogDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i175.PatientFileRepo>(
      () => _i555.PatientFileRepoImpl(gh<_i743.PatientFileDataSource>()),
    );
    gh.lazySingleton<_i487.SearchDoctorsDataSource>(
      () => _i834.SearchDoctorsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i982.DoctorChatDataSource>(
      () => _i462.DoctorChatDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i503.PatientWalletDataSource>(
      () => _i470.PatientWalletDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.factory<_i854.CreateReportViewModel>(
      () => _i854.CreateReportViewModel(
        doctorAppointmentsRepo: gh<_i838.DoctorAppointmentsRepo>(),
      ),
    );
    gh.factory<_i807.DoctorAppointmentDetailsViewModel>(
      () => _i807.DoctorAppointmentDetailsViewModel(
        doctorAppointmentsRepo: gh<_i838.DoctorAppointmentsRepo>(),
      ),
    );
    gh.factory<_i483.DoctorAppointmentsViewModel>(
      () => _i483.DoctorAppointmentsViewModel(
        doctorAppointmentsRepo: gh<_i838.DoctorAppointmentsRepo>(),
      ),
    );
    gh.lazySingleton<_i68.DoctorPatientsRepo>(
      () => _i922.DoctorPatientsRepoImpl(gh<_i966.DoctorPatientsDataSource>()),
    );
    gh.lazySingleton<_i535.DoctorOnboardingDataSource>(
      () => _i365.DoctorOnboardingDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i517.DoctorProfileDataSource>(
      () => _i898.DoctorProfileDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i181.PatientHomeRepo>(
      () => _i450.PatientHomeRepoImpl(gh<_i317.PatientHomeDataSource>()),
    );
    gh.lazySingleton<_i105.PatientNotificationsRepo>(
      () => _i855.PatientNotificationsRepoImpl(
        gh<_i319.PatientNotificationsDataSource>(),
      ),
    );
    gh.lazySingleton<_i798.AppointmentsRepo>(
      () => _i345.AppointmentsRepoImpl(gh<_i127.AppointmentsDataSource>()),
    );
    gh.factory<_i891.DoctorAuthViewModel>(
      () => _i891.DoctorAuthViewModel(authRepo: gh<_i53.DoctorAuthRepo>()),
    );
    gh.lazySingleton<_i290.SearchDoctorsRepo>(
      () => _i227.SearchDoctorsRepoImpl(gh<_i487.SearchDoctorsDataSource>()),
    );
    gh.lazySingleton<_i286.DoctorOnboardingRepo>(
      () =>
          _i54.DoctorOnboardingRepoImpl(gh<_i535.DoctorOnboardingDataSource>()),
    );
    gh.factory<_i7.AppointmentDetailsViewModel>(
      () => _i7.AppointmentDetailsViewModel(
        appointmentsRepo: gh<_i798.AppointmentsRepo>(),
      ),
    );
    gh.factory<_i671.AppointmentsViewModel>(
      () => _i671.AppointmentsViewModel(
        appointmentsRepo: gh<_i798.AppointmentsRepo>(),
      ),
    );
    gh.factory<_i646.PatientInvoicesViewModel>(
      () => _i646.PatientInvoicesViewModel(
        appointmentsRepo: gh<_i798.AppointmentsRepo>(),
      ),
    );
    gh.factory<_i444.PaymentSuccessViewModel>(
      () => _i444.PaymentSuccessViewModel(
        appointmentsRepo: gh<_i798.AppointmentsRepo>(),
      ),
    );
    gh.factory<_i647.DoctorPatientsViewModel>(
      () => _i647.DoctorPatientsViewModel(
        doctorPatientsRepo: gh<_i68.DoctorPatientsRepo>(),
      ),
    );
    gh.lazySingleton<_i692.PatientChatRepo>(
      () => _i544.PatientChatRepoImpl(gh<_i993.PatientChatDataSource>()),
    );
    gh.factory<_i119.PatientHomeViewModel>(
      () => _i119.PatientHomeViewModel(
        patientHomeRepo: gh<_i181.PatientHomeRepo>(),
      ),
    );
    gh.lazySingleton<_i311.PatientAuthRepo>(
      () => _i288.PatientAuthRepoImpl(gh<_i108.PatientRemoteDataSource>()),
    );
    gh.lazySingleton<_i600.DoctorCallsRepo>(
      () => _i879.DoctorCallsRepoImpl(gh<_i536.DoctorCallsDataSource>()),
    );
    gh.factory<_i702.PatientFileViewModel>(
      () => _i702.PatientFileViewModel(
        patientFileRepo: gh<_i175.PatientFileRepo>(),
      ),
    );
    gh.factory<_i339.PatientNotificationsViewModel>(
      () => _i339.PatientNotificationsViewModel(
        notificationsRepo: gh<_i105.PatientNotificationsRepo>(),
      ),
    );
    gh.factory<_i273.PatientChatDetailsViewModel>(
      () => _i273.PatientChatDetailsViewModel(
        chatRepo: gh<_i692.PatientChatRepo>(),
      ),
    );
    gh.factory<_i586.PatientChatListViewModel>(
      () =>
          _i586.PatientChatListViewModel(chatRepo: gh<_i692.PatientChatRepo>()),
    );
    gh.factory<_i873.PatientStartConsultationViewModel>(
      () => _i873.PatientStartConsultationViewModel(
        chatRepo: gh<_i692.PatientChatRepo>(),
      ),
    );
    gh.factory<_i551.CompleteDocProfileCubit>(
      () => _i551.CompleteDocProfileCubit(
        gh<_i772.ImagePickerServices>(),
        gh<_i286.DoctorOnboardingRepo>(),
      ),
    );
    gh.lazySingleton<_i386.PatientCatalogRepo>(
      () => _i327.PatientCatalogRepoImpl(gh<_i30.PatientCatalogDataSource>()),
    );
    gh.lazySingleton<_i307.DoctorDetailsRepo>(
      () => _i363.DoctorDetailsRepoImpl(gh<_i1029.DoctorDetailsDataSource>()),
    );
    gh.lazySingleton<_i1038.DoctorScheduleRepo>(
      () => _i437.DoctorScheduleRepoImpl(gh<_i276.DoctorScheduleDataSource>()),
    );
    gh.lazySingleton<_i523.DoctorDashboardRepo>(
      () =>
          _i933.DoctorDashboardRepoImpl(gh<_i374.DoctorDashboardDataSource>()),
    );
    gh.factory<_i392.PatientVideoCallViewModel>(
      () => _i392.PatientVideoCallViewModel(
        callsRepo: gh<_i871.PatientCallsRepo>(),
        agoraRtcService: gh<_i639.AgoraRtcService>(),
      ),
    );
    gh.factory<_i537.DoctorDashboardViewModel>(
      () => _i537.DoctorDashboardViewModel(
        doctorDashboardRepo: gh<_i523.DoctorDashboardRepo>(),
        doctorAppointmentsRepo: gh<_i838.DoctorAppointmentsRepo>(),
      ),
    );
    gh.factory<_i399.DoctorDetailsViewModel>(
      () => _i399.DoctorDetailsViewModel(
        doctorDetailsRepo: gh<_i307.DoctorDetailsRepo>(),
      ),
    );
    gh.lazySingleton<_i320.PatientProfileRepo>(
      () => _i991.PatientProfileRepoImpl(gh<_i744.PatientProfileDataSource>()),
    );
    gh.lazySingleton<_i896.PatientWalletRepo>(
      () => _i1014.PatientWalletRepoImpl(gh<_i503.PatientWalletDataSource>()),
    );
    gh.factory<_i9.PrescriptionDetailsViewModel>(
      () => _i9.PrescriptionDetailsViewModel(
        recordsRepo: gh<_i475.RecordsRepo>(),
      ),
    );
    gh.factory<_i139.RecordsViewModel>(
      () => _i139.RecordsViewModel(recordsRepo: gh<_i475.RecordsRepo>()),
    );
    gh.factory<_i453.ReportDetailsViewModel>(
      () => _i453.ReportDetailsViewModel(recordsRepo: gh<_i475.RecordsRepo>()),
    );
    gh.lazySingleton<_i114.DoctorProfileRepo>(
      () => _i961.DoctorProfileRepoImpl(gh<_i517.DoctorProfileDataSource>()),
    );
    gh.lazySingleton<_i570.PatientHealthProfileRepo>(
      () => _i947.PatientHealthProfileRepoImpl(
        gh<_i123.PatientHealthProfileDataSource>(),
      ),
    );
    gh.factory<_i381.DoctorWalletViewModel>(
      () =>
          _i381.DoctorWalletViewModel(walletRepo: gh<_i882.DoctorWalletRepo>()),
    );
    gh.factory<_i663.DoctorWithdrawViewModel>(
      () => _i663.DoctorWithdrawViewModel(
        walletRepo: gh<_i882.DoctorWalletRepo>(),
      ),
    );
    gh.factory<_i927.DoctorWithdrawalDetailsViewModel>(
      () => _i927.DoctorWithdrawalDetailsViewModel(
        walletRepo: gh<_i882.DoctorWalletRepo>(),
      ),
    );
    gh.factory<_i323.DoctorVideoCallViewModel>(
      () => _i323.DoctorVideoCallViewModel(
        callsRepo: gh<_i600.DoctorCallsRepo>(),
        agoraRtcService: gh<_i639.AgoraRtcService>(),
      ),
    );
    gh.lazySingleton<_i43.DoctorChatRepo>(
      () => _i274.DoctorChatRepoImpl(gh<_i982.DoctorChatDataSource>()),
    );
    gh.lazySingleton<_i95.DoctorNotificationsRepo>(
      () => _i884.DoctorNotificationsRepoImpl(
        gh<_i405.DoctorNotificationsDataSource>(),
      ),
    );
    gh.factory<_i150.SearchDoctorsViewModel>(
      () => _i150.SearchDoctorsViewModel(
        searchDoctorsRepo: gh<_i290.SearchDoctorsRepo>(),
      ),
    );
    gh.factory<_i48.DoctorScheduleViewModel>(
      () => _i48.DoctorScheduleViewModel(
        doctorScheduleRepo: gh<_i1038.DoctorScheduleRepo>(),
      ),
    );
    gh.factory<_i918.SpecialtiesViewModel>(
      () => _i918.SpecialtiesViewModel(
        doctorOnboardingRepo: gh<_i386.PatientCatalogRepo>(),
      ),
    );
    gh.factory<_i851.PatientAuthViewModel>(
      () => _i851.PatientAuthViewModel(authRepo: gh<_i311.PatientAuthRepo>()),
    );
    gh.factory<_i669.CompletePatientProfileViewModel>(
      () => _i669.CompletePatientProfileViewModel(
        imagePicker: gh<_i772.ImagePickerServices>(),
        patientHealthProfileRepo: gh<_i570.PatientHealthProfileRepo>(),
      ),
    );
    gh.factory<_i863.PatientProfileViewModel>(
      () => _i863.PatientProfileViewModel(
        patientProfileRepo: gh<_i320.PatientProfileRepo>(),
        authRepo: gh<_i311.PatientAuthRepo>(),
      ),
    );
    gh.factory<_i801.WalletViewModel>(
      () => _i801.WalletViewModel(walletRepo: gh<_i896.PatientWalletRepo>()),
    );
    gh.factory<_i457.DoctorProfileViewModel>(
      () => _i457.DoctorProfileViewModel(
        doctorProfileRepo: gh<_i114.DoctorProfileRepo>(),
        authRepo: gh<_i53.DoctorAuthRepo>(),
      ),
    );
    gh.factory<_i853.DoctorChatDetailsViewModel>(
      () =>
          _i853.DoctorChatDetailsViewModel(chatRepo: gh<_i43.DoctorChatRepo>()),
    );
    gh.factory<_i265.DoctorChatListViewModel>(
      () => _i265.DoctorChatListViewModel(chatRepo: gh<_i43.DoctorChatRepo>()),
    );
    gh.factory<_i685.DoctorStartConsultationViewModel>(
      () => _i685.DoctorStartConsultationViewModel(
        chatRepo: gh<_i43.DoctorChatRepo>(),
      ),
    );
    gh.factory<_i802.ConfirmPaymentViewModel>(
      () => _i802.ConfirmPaymentViewModel(
        appointmentsRepo: gh<_i798.AppointmentsRepo>(),
        walletRepo: gh<_i896.PatientWalletRepo>(),
      ),
    );
    gh.factory<_i129.DoctorNotificationsViewModel>(
      () => _i129.DoctorNotificationsViewModel(
        notificationsRepo: gh<_i95.DoctorNotificationsRepo>(),
      ),
    );
    return this;
  }
}

class _$ApiModule extends _i0.ApiModule {}
