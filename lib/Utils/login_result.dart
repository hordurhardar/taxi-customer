class SocialLoginResult {
  bool status;
  String message;
  String? emailAddress, socialId, image, name, socialType;

  SocialLoginResult(
      {required this.status,
      required this.message,
      this.emailAddress,
      this.socialId,
      this.image,
      this.name,
      this.socialType});
}
