import 'package:first_project/redux-store/actions/login_page_actions.dart';
import 'package:first_project/redux-store/models/app_state.dart';
import 'package:redux/redux.dart';

class LoginViewModel {
  final bool agreedToTerms;
  final Function(bool) toggleTerms;

  LoginViewModel({
    required this.agreedToTerms,
    required this.toggleTerms,
  });

  

  static LoginViewModel fromStore(Store<AppState> store) {
    return LoginViewModel(
      agreedToTerms: store.state.loginPageState.agreedToTerms,
      toggleTerms: (bool value) {
        store.dispatch(ToggleTermsAction(value));
      },
    );
  }
}
