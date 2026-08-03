import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LayoutViewModel extends Cubit<int> {
  LayoutViewModel() : super(0);

  void changeIndex(int index) => emit(index);
}
