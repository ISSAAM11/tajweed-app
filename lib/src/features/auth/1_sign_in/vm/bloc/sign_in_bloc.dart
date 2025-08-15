import '../../../../../base/bloc/exports.dart';
import '../../data/models/user.dart';
import '../../datasource/sign_in_datasource.dart';
import '../events/sign_in_events.dart';
import '../states/sign_in_states.dart';

//$ USE CASES
part '../usecases/sign_in_uc.dart'  ;

class SignInBloc extends BaseBloc<SignInEvent, SignInState> {
  final SignInDataSource signInDataSource;

  SignInBloc(this.signInDataSource) : super(Loading(), debugginEnabled: true) {
    on<SignIn>(_signIn);
  }

  //? OBERVABLES
  // final accessingHomeObs = Observable<bool>(false);

  //& LIFECYCLE
  @override
  void onReady() {
    super.onReady();
  }

  
}
