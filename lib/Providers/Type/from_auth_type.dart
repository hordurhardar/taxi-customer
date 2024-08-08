enum FromAuthType {
  fromSignUp(0, 'signup'),
  fromLogin(1, 'login'),
  fromForgotPassword(2, 'forgotPassword'),
  fromProfile(3, 'profile');

  final int id;
  final String description;

  const
  FromAuthType(this.id, this.description);
}
