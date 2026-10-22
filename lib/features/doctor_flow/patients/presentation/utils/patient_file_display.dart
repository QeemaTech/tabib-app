String patientFileDisplay(String? value) {
  final trimmed = value?.trim() ?? '';
  return trimmed.isEmpty ? '----' : trimmed;
}
