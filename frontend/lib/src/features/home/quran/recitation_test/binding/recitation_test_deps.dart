import 'package:tajweed_ai/src/app/binding/app_bindings.dart';
import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';

import '../data/datasource/recitation_socket_client.dart';
import '../vm/recitation_test_bloc.dart';

class RecitationTestDeps {
  void inject() {
    di.registerLazySingleton<RecitationSocketClient>(
      () => RecitationSocketClient(),
    );
    di.registerInstance<RecitationTestBloc>(
      RecitationTestBloc(
        dao: get<QuranPageDao>(),
        socket: get<RecitationSocketClient>(),
      ),
    );
  }
}
