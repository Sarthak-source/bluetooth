class LoginState {
  final bool isLoggedIn;
  final bool agreedToTerms;

  LoginState({
    required this.isLoggedIn,
    required this.agreedToTerms,
  });

  factory LoginState.initialState() {
    return LoginState(
      isLoggedIn: false,
      agreedToTerms: false,
    );
  }

  LoginState copyWith({
    bool? isLoggedIn,
    bool? agreedToTerms,
  }) {
    return LoginState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      agreedToTerms: agreedToTerms ?? this.agreedToTerms,
    );
  }
}
