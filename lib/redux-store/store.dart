// main.dart or wherever you initialize the store
import 'package:first_project/redux-store/models/app_state.dart';
import 'package:first_project/redux-store/models/home_state.dart';
import 'package:redux/redux.dart';

import 'combained_reducer.dart';
import 'models/log_in_state.dart';

final store = Store<AppState>(
  mainReducer,
  initialState: AppState( homePageState: HomePageState.initialState(), loginPageState: LoginState.initialState()),
);
