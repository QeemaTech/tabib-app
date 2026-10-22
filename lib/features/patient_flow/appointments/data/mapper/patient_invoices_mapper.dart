import 'dart:typed_data';

import 'package:retrofit/retrofit.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/mapper/patient_invoice_mapper.dart';
import 'package:tabib_app/features/patient_flow/appointments/data/models/response/patient_invoices_response.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/invoice_file_entity.dart';
import 'package:tabib_app/features/patient_flow/appointments/domain/entities/patient_invoices_page_entity.dart';

extension PatientInvoicesResponseMapper on PatientInvoicesResponse {
  PatientInvoicesPageEntity toEntity() {
    return PatientInvoicesPageEntity(
      items: data?.map((item) => item.toEntity()).toList() ?? const [],
      page: meta?.page ?? 1,
      limit: meta?.limit ?? 20,
      total: meta?.total ?? 0,
      totalPages: meta?.totalPages ?? 1,
    );
  }
}

extension InvoiceDownloadResponseMapper on HttpResponse<Uint8List> {
  InvoiceFileEntity toEntity() {
    return InvoiceFileEntity(
      bytes: data,
      fileName: _fileName(response.headers.value('content-disposition')),
    );
  }
}

String _fileName(String? header) {
  if (header == null || header.isEmpty) return 'invoice.pdf';
  final encoded = RegExp(
    r"filename\*=UTF-8''([^;]+)",
    caseSensitive: false,
  ).firstMatch(header);
  if (encoded != null) {
    final value = encoded.group(1)?.trim().replaceAll('"', '') ?? '';
    if (value.isNotEmpty) return Uri.decodeComponent(value);
  }
  final plain = RegExp(
    r'filename="?([^";]+)"?',
    caseSensitive: false,
  ).firstMatch(header);
  final name = plain?.group(1)?.trim() ?? '';
  if (name.isEmpty) return 'invoice.pdf';
  return name;
}
