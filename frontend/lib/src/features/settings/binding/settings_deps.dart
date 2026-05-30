import 'package:tajweed_ai/src/app/locale/locale_bloc.dart';
import 'package:tajweed_ai/src/base/dependencies/dependencies.dart';
import 'package:tajweed_ai/src/features/settings/vm/settings_bloc.dart';

class SettingsDependencies implements Dependencies {
  @override
  void inject() {
    di.registerLazySingleton<SettingsBloc>(
      () => SettingsBloc(get<LocaleBloc>()),
    );
  }
}
