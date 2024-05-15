// lib/redux-store/reducers/main_reducer.dart
import 'package:first_project/redux-store/models/app_state.dart';
import 'package:first_project/redux-store/reducers/home_reducer.dart';
import 'package:first_project/redux-store/reducers/log_in_reducers.dart';

AppState mainReducer(AppState state, dynamic action) {
  return AppState(
    homePageState: homeReducer(state.homePageState, action),
    loginPageState: loginReducer(state.loginPageState, action),
  );
}
