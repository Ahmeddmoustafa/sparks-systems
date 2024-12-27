import 'package:flutter_bloc/flutter_bloc.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState(locale: 'en'));

  void changeLocale(bool value) {
    switch (value) {
      case true:
        emit(LocaleState(locale: 'en'));
      case false:
        emit(LocaleState(locale: 'ar'));
    }
  }
}
