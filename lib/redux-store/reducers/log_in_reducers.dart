import 'package:first_project/redux-store/actions/login_page_actions.dart';
import 'package:first_project/redux-store/models/log_in_state.dart';

LoginState loginReducer(LoginState state, dynamic action) {
  if (action is ToggleTermsAction) {
    return state.copyWith(agreedToTerms: action.value);
  }
  if (action is LoginAction) {
    return state.copyWith(isLoggedIn: action.value);
  }
  return state;
}
