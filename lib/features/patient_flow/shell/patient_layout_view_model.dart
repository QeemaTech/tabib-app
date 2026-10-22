import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PatientLayoutViewModel extends Cubit<int> {
  PatientLayoutViewModel() : super(0);

  void changeIndex(int index) => emit(index);
}
