class VideoCallArgs {
  final String appointmentId;
  final String callType;
  final String peerName;

  const VideoCallArgs({
    required this.appointmentId,
    required this.callType,
    this.peerName = '',
  });

  static VideoCallArgs fromRouteArguments(Object? arguments) {
    if (arguments is VideoCallArgs) return arguments;
    if (arguments is Map) {
      return VideoCallArgs(
        appointmentId: (arguments['appointmentId'] as String?) ?? '',
        callType: (arguments['callType'] as String?) ?? 'VIDEO',
        peerName: (arguments['peerName'] as String?) ?? '',
      );
    }
    return const VideoCallArgs(appointmentId: '', callType: 'VIDEO');
  }
}
