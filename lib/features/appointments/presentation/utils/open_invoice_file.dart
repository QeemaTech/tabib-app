import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:tabib_app/features/appointments/domain/entities/invoice_file_entity.dart';

Future<bool> saveAndOpenInvoiceFile(InvoiceFileEntity file) async {
  if (file.bytes.isEmpty) return false;
  final safeName = file.fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  final path = '${Directory.systemTemp.path}${Platform.pathSeparator}$safeName';
  await File(path).writeAsBytes(file.bytes, flush: true);
  final opened = await OpenFilex.open(path, type: 'application/pdf');
  return opened.type == ResultType.done;
}
