class ChatDetailsArgs {
  final String consultationId;
  final String title;
  final String avatarUrl;

  const ChatDetailsArgs({
    required this.consultationId,
    this.title = '',
    this.avatarUrl = '',
  });

  static ChatDetailsArgs fromRouteArguments(Object? arguments) {
    if (arguments is ChatDetailsArgs) return arguments;
    if (arguments is String) {
      return ChatDetailsArgs(consultationId: arguments);
    }
    if (arguments is Map) {
      return ChatDetailsArgs(
        consultationId: (arguments['id'] as String?) ??
            (arguments['consultationId'] as String?) ??
            '',
        title: (arguments['title'] as String?) ?? '',
        avatarUrl: (arguments['avatarUrl'] as String?) ?? '',
      );
    }
    return const ChatDetailsArgs(consultationId: '');
  }
}
