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
import '../../features/appointments/presentation/view_model/appointment_details_view_model.dart'
    as _i364;
import '../../features/appointments/presentation/view_model/appointments_view_model.dart'
    as _i486;
import '../../features/appointments/presentation/view_model/confirm_payment_view_model.dart'
    as _i975;
import '../../features/appointments/presentation/view_model/patient_invoices_view_model.dart'
    as _i565;
import '../../features/appointments/presentation/view_model/payment_success_view_model.dart'
    as _i325;
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
    as _i53;
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
import '../../features/calls/data/data_source/calls_data_source.dart' as _i713;
import '../../features/calls/data/data_source/calls_data_source_impl.dart'
    as _i16;
import '../../features/calls/data/repo/calls_repo_impl.dart' as _i1064;
import '../../features/calls/domain/repo/calls_repo.dart' as _i935;
import '../../features/calls/presentation/view_model/video_call_view_model.dart'
    as _i38;
import '../../features/chat/data/data_source/chat_data_source.dart' as _i542;
import '../../features/chat/data/data_source/chat_data_source_impl.dart'
    as _i304;
import '../../features/chat/data/repo/chat_repo_impl.dart' as _i328;
import '../../features/chat/domain/repo/chat_repo.dart' as _i804;
import '../../features/chat/presentation/view_model/chat_details_view_model.dart'
    as _i849;
import '../../features/chat/presentation/view_model/chat_list_view_model.dart'
    as _i1016;
import '../../features/chat/presentation/view_model/start_consultation_view_model.dart'
    as _i856;
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
    as _i961;
import '../../features/home/data/data_source/search_doctors_data_source_impl.dart'
    as _i556;
import '../../features/home/data/repo/doctor_dashboard_repo_impl.dart' as _i157;
import '../../features/home/data/repo/doctor_details_repo_impl.dart' as _i1007;
import '../../features/home/data/repo/patient_home_repo_impl.dart' as _i455;
import '../../features/home/data/repo/search_doctors_repo_impl.dart' as _i232;
import '../../features/home/domain/repo/doctor_dashboard_repo.dart' as _i845;
import '../../features/home/domain/repo/doctor_details_repo.dart' as _i806;
import '../../features/home/domain/repo/patient_home_repo.dart' as _i848;
import '../../features/home/domain/repo/search_doctors_repo.dart' as _i824;
import '../../features/home/presentation/view_model/doctor_dashboard_view_model.dart'
    as _i720;
import '../../features/home/presentation/view_model/doctor_details_view_model.dart'
    as _i93;
import '../../features/home/presentation/view_model/patient_home_view_model.dart'
    as _i241;
import '../../features/home/presentation/view_model/search_doctors_view_model.dart'
    as _i54;
import '../../features/home/presentation/view_model/specialties_view_model.dart'
    as _i32;
import '../../features/layout/view_model/layout_view_model.dart' as _i566;
import '../../features/notification/data/data_source/notifications_data_source.dart'
    as _i921;
import '../../features/notification/data/data_source/notifications_data_source_impl.dart'
    as _i808;
import '../../features/notification/data/repo/notifications_repo_impl.dart'
    as _i620;
import '../../features/notification/domain/repo/notifications_repo.dart'
    as _i846;
import '../../features/notification/presentation/view_model/notifications_view_model.dart'
    as _i1026;
import '../../features/patients/data/data_source/doctor_patients_data_source.dart'
    as _i1062;
import '../../features/patients/data/data_source/doctor_patients_data_source_impl.dart'
    as _i960;
import '../../features/patients/data/data_source/patient_file_data_source.dart'
    as _i847;
import '../../features/patients/data/data_source/patient_file_data_source_impl.dart'
    as _i729;
import '../../features/patients/data/repo/doctor_patients_repo_impl.dart'
    as _i269;
import '../../features/patients/data/repo/patient_file_repo_impl.dart' as _i822;
import '../../features/patients/domain/repo/doctor_patients_repo.dart' as _i471;
import '../../features/patients/domain/repo/patient_file_repo.dart' as _i305;
import '../../features/patients/presentation/view_model/doctor_patients_view_model.dart'
    as _i838;
import '../../features/patients/presentation/view_model/patient_file_view_model.dart'
    as _i452;
import '../../features/profile/data/data_source/doctor_profile_data_source.dart'
    as _i567;
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
import '../../features/reservations/data/data_source/doctor_appointments_data_source.dart'
    as _i702;
import '../../features/reservations/data/data_source/doctor_appointments_data_source_impl.dart'
    as _i657;
import '../../features/reservations/data/repo/doctor_appointments_repo_impl.dart'
    as _i308;
import '../../features/reservations/domain/repo/doctor_appointments_repo.dart'
    as _i763;
import '../../features/reservations/presentation/view_model/create_report_view_model.dart'
    as _i142;
import '../../features/reservations/presentation/view_model/doctor_appointment_details_view_model.dart'
    as _i62;
import '../../features/reservations/presentation/view_model/doctor_appointments_view_model.dart'
    as _i773;
import '../../features/schedule/data/data_source/doctor_schedule_data_source.dart'
    as _i294;
import '../../features/schedule/data/data_source/doctor_schedule_data_source_impl.dart'
    as _i622;
import '../../features/schedule/data/repo/doctor_schedule_repo_impl.dart'
    as _i46;
import '../../features/schedule/domain/repo/doctor_schedule_repo.dart' as _i906;
import '../../features/schedule/presentation/view_model/doctor_schedule_view_model.dart'
    as _i986;
import '../../features/wallet/data/data_source/wallet_data_source.dart'
    as _i914;
import '../../features/wallet/data/data_source/wallet_data_source_impl.dart'
    as _i474;
import '../../features/wallet/data/repo/wallet_repo_impl.dart' as _i925;
import '../../features/wallet/domain/repo/wallet_repo.dart' as _i413;
import '../../features/wallet/presentation/view_model/doctor_wallet_view_model.dart'
    as _i587;
import '../../features/wallet/presentation/view_model/doctor_withdraw_view_model.dart'
    as _i129;
import '../../features/wallet/presentation/view_model/doctor_withdrawal_details_view_model.dart'
    as _i80;
import '../../features/wallet/presentation/view_model/wallet_view_model.dart'
    as _i226;
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
    gh.factory<_i566.LayoutViewModel>(() => _i566.LayoutViewModel());
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
    gh.lazySingleton<_i25.DoctorDashboardDataSource>(
      () => _i204.DoctorDashboardDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i921.NotificationsDataSource>(
      () => _i808.NotificationsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i10.DoctorDetailsDataSource>(
      () => _i276.DoctorDetailsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i275.AppointmentsDataSource>(
      () => _i47.AppointmentsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i1062.DoctorPatientsDataSource>(
      () => _i960.DoctorPatientsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i577.DoctorOnboardingDataSource>(
      () => _i651.DoctorOnboardingDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i862.PatientHomeDataSource>(
      () => _i443.PatientHomeDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i294.DoctorScheduleDataSource>(
      () => _i622.DoctorScheduleDataSourceImpl(gh<_i277.ApiClient>()),
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
    gh.lazySingleton<_i846.NotificationsRepo>(
      () => _i620.NotificationsRepoImpl(gh<_i921.NotificationsDataSource>()),
    );
    gh.lazySingleton<_i407.PatientProfileRepo>(
      () => _i544.PatientProfileRepoImpl(gh<_i311.PatientProfileDataSource>()),
    );
    gh.lazySingleton<_i567.DoctorProfileDataSource>(
      () => _i344.DoctorProfileDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i845.DoctorDashboardRepo>(
      () => _i157.DoctorDashboardRepoImpl(gh<_i25.DoctorDashboardDataSource>()),
    );
    gh.lazySingleton<_i217.RemoteDataSource>(
      () => _i53.RemoteDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i961.SearchDoctorsDataSource>(
      () => _i556.SearchDoctorsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i542.ChatDataSource>(
      () => _i304.ChatDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i702.DoctorAppointmentsDataSource>(
      () => _i657.DoctorAppointmentsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i847.PatientFileDataSource>(
      () => _i729.PatientFileDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i659.PatientHealthProfileDataSource>(
      () => _i362.PatientHealthProfileDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i914.WalletDataSource>(
      () => _i474.WalletDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i713.CallsDataSource>(
      () => _i16.CallsDataSourceImpl(gh<_i277.ApiClient>()),
    );
    gh.lazySingleton<_i541.PatientHealthProfileRepo>(
      () => _i49.PatientHealthProfileRepoImpl(
        gh<_i659.PatientHealthProfileDataSource>(),
      ),
    );
    gh.lazySingleton<_i906.DoctorScheduleRepo>(
      () => _i46.DoctorScheduleRepoImpl(gh<_i294.DoctorScheduleDataSource>()),
    );
    gh.lazySingleton<_i413.WalletRepo>(
      () => _i925.WalletRepoImpl(gh<_i914.WalletDataSource>()),
    );
    gh.lazySingleton<_i824.SearchDoctorsRepo>(
      () => _i232.SearchDoctorsRepoImpl(gh<_i961.SearchDoctorsDataSource>()),
    );
    gh.lazySingleton<_i201.AppointmentsRepo>(
      () => _i611.AppointmentsRepoImpl(gh<_i275.AppointmentsDataSource>()),
    );
    gh.factory<_i975.ConfirmPaymentViewModel>(
      () => _i975.ConfirmPaymentViewModel(
        appointmentsRepo: gh<_i201.AppointmentsRepo>(),
        walletRepo: gh<_i413.WalletRepo>(),
      ),
    );
    gh.factory<_i587.DoctorWalletViewModel>(
      () => _i587.DoctorWalletViewModel(walletRepo: gh<_i413.WalletRepo>()),
    );
    gh.factory<_i129.DoctorWithdrawViewModel>(
      () => _i129.DoctorWithdrawViewModel(walletRepo: gh<_i413.WalletRepo>()),
    );
    gh.factory<_i80.DoctorWithdrawalDetailsViewModel>(
      () => _i80.DoctorWithdrawalDetailsViewModel(
        walletRepo: gh<_i413.WalletRepo>(),
      ),
    );
    gh.factory<_i226.WalletViewModel>(
      () => _i226.WalletViewModel(walletRepo: gh<_i413.WalletRepo>()),
    );
    gh.lazySingleton<_i64.DoctorProfileRepo>(
      () => _i1050.DoctorProfileRepoImpl(gh<_i567.DoctorProfileDataSource>()),
    );
    gh.factory<_i1026.NotificationsViewModel>(
      () => _i1026.NotificationsViewModel(
        notificationsRepo: gh<_i846.NotificationsRepo>(),
      ),
    );
    gh.lazySingleton<_i170.AuthRepo>(
      () => _i984.AuthRepoImpl(gh<_i217.RemoteDataSource>()),
    );
    gh.lazySingleton<_i804.ChatRepo>(
      () => _i328.ChatRepoImpl(gh<_i542.ChatDataSource>()),
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
    gh.factory<_i54.SearchDoctorsViewModel>(
      () => _i54.SearchDoctorsViewModel(
        searchDoctorsRepo: gh<_i824.SearchDoctorsRepo>(),
      ),
    );
    gh.lazySingleton<_i848.PatientHomeRepo>(
      () => _i455.PatientHomeRepoImpl(gh<_i862.PatientHomeDataSource>()),
    );
    gh.factory<_i32.SpecialtiesViewModel>(
      () => _i32.SpecialtiesViewModel(
        doctorOnboardingRepo: gh<_i313.DoctorOnboardingRepo>(),
      ),
    );
    gh.lazySingleton<_i471.DoctorPatientsRepo>(
      () => _i269.DoctorPatientsRepoImpl(gh<_i1062.DoctorPatientsDataSource>()),
    );
    gh.lazySingleton<_i935.CallsRepo>(
      () => _i1064.CallsRepoImpl(gh<_i713.CallsDataSource>()),
    );
    gh.lazySingleton<_i305.PatientFileRepo>(
      () => _i822.PatientFileRepoImpl(gh<_i847.PatientFileDataSource>()),
    );
    gh.factory<_i986.DoctorScheduleViewModel>(
      () => _i986.DoctorScheduleViewModel(
        doctorScheduleRepo: gh<_i906.DoctorScheduleRepo>(),
      ),
    );
    gh.factory<_i765.CompletePatientProfileViewModel>(
      () => _i765.CompletePatientProfileViewModel(
        imagePicker: gh<_i772.ImagePickerServices>(),
        patientHealthProfileRepo: gh<_i541.PatientHealthProfileRepo>(),
      ),
    );
    gh.lazySingleton<_i763.DoctorAppointmentsRepo>(
      () => _i308.DoctorAppointmentsRepoImpl(
        gh<_i702.DoctorAppointmentsDataSource>(),
      ),
    );
    gh.factory<_i38.VideoCallViewModel>(
      () => _i38.VideoCallViewModel(
        callsRepo: gh<_i935.CallsRepo>(),
        agoraRtcService: gh<_i639.AgoraRtcService>(),
      ),
    );
    gh.factory<_i838.DoctorPatientsViewModel>(
      () => _i838.DoctorPatientsViewModel(
        doctorPatientsRepo: gh<_i471.DoctorPatientsRepo>(),
      ),
    );
    gh.factory<_i142.CreateReportViewModel>(
      () => _i142.CreateReportViewModel(
        doctorAppointmentsRepo: gh<_i763.DoctorAppointmentsRepo>(),
      ),
    );
    gh.factory<_i62.DoctorAppointmentDetailsViewModel>(
      () => _i62.DoctorAppointmentDetailsViewModel(
        doctorAppointmentsRepo: gh<_i763.DoctorAppointmentsRepo>(),
      ),
    );
    gh.factory<_i773.DoctorAppointmentsViewModel>(
      () => _i773.DoctorAppointmentsViewModel(
        doctorAppointmentsRepo: gh<_i763.DoctorAppointmentsRepo>(),
      ),
    );
    gh.factory<_i364.AppointmentDetailsViewModel>(
      () => _i364.AppointmentDetailsViewModel(
        appointmentsRepo: gh<_i201.AppointmentsRepo>(),
      ),
    );
    gh.factory<_i486.AppointmentsViewModel>(
      () => _i486.AppointmentsViewModel(
        appointmentsRepo: gh<_i201.AppointmentsRepo>(),
      ),
    );
    gh.factory<_i565.PatientInvoicesViewModel>(
      () => _i565.PatientInvoicesViewModel(
        appointmentsRepo: gh<_i201.AppointmentsRepo>(),
      ),
    );
    gh.factory<_i325.PaymentSuccessViewModel>(
      () => _i325.PaymentSuccessViewModel(
        appointmentsRepo: gh<_i201.AppointmentsRepo>(),
      ),
    );
    gh.factory<_i162.DoctorProfileViewModel>(
      () => _i162.DoctorProfileViewModel(
        doctorProfileRepo: gh<_i64.DoctorProfileRepo>(),
        authRepo: gh<_i170.AuthRepo>(),
      ),
    );
    gh.factory<_i369.PatientProfileViewModel>(
      () => _i369.PatientProfileViewModel(
        patientProfileRepo: gh<_i407.PatientProfileRepo>(),
        authRepo: gh<_i170.AuthRepo>(),
      ),
    );
    gh.factory<_i849.ChatDetailsViewModel>(
      () => _i849.ChatDetailsViewModel(chatRepo: gh<_i804.ChatRepo>()),
    );
    gh.factory<_i1016.ChatListViewModel>(
      () => _i1016.ChatListViewModel(chatRepo: gh<_i804.ChatRepo>()),
    );
    gh.factory<_i856.StartConsultationViewModel>(
      () => _i856.StartConsultationViewModel(chatRepo: gh<_i804.ChatRepo>()),
    );
    gh.factory<_i1025.AuthViewModel>(
      () => _i1025.AuthViewModel(authRepo: gh<_i170.AuthRepo>()),
    );
    gh.factory<_i452.PatientFileViewModel>(
      () => _i452.PatientFileViewModel(
        patientFileRepo: gh<_i305.PatientFileRepo>(),
      ),
    );
    gh.factory<_i241.PatientHomeViewModel>(
      () => _i241.PatientHomeViewModel(
        patientHomeRepo: gh<_i848.PatientHomeRepo>(),
      ),
    );
    gh.factory<_i720.DoctorDashboardViewModel>(
      () => _i720.DoctorDashboardViewModel(
        doctorDashboardRepo: gh<_i845.DoctorDashboardRepo>(),
        doctorAppointmentsRepo: gh<_i763.DoctorAppointmentsRepo>(),
      ),
    );
    return this;
  }
}

class _$ApiModule extends _i0.ApiModule {}
