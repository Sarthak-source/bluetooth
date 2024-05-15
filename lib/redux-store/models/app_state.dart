import 'home_state.dart';
import 'log_in_state.dart';

class AppState {
  final LoginState loginPageState;
  final HomePageState homePageState;

  AppState({
    required this.loginPageState,
    required this.homePageState,
  });

  // Initial state for the entire app
  factory AppState.initialState() {
    return AppState(
      loginPageState: LoginState.initialState(),
      homePageState: HomePageState.initialState(),
    );
  }
}