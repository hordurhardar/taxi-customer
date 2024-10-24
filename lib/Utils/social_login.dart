library social_login;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:taxi/Utils/login_result.dart';

class SocialLogin extends ChangeNotifier {
  SocialLogin._();
  static SocialLogin instance = SocialLogin._();
  GoogleSignIn? googleSignIn;

// /apple login

  Future<SocialLoginResult> appleLogin() async {
    try {
      final appleLogin = await SignInWithApple.getAppleIDCredential(
          scopes: const [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName
          ]);

      return SocialLoginResult(
          status: true,
          message: 'You have successfully Logged In',
          socialType: 'Apple',
          emailAddress: appleLogin.email ?? "",
          socialId: appleLogin.userIdentifier ?? "",
          image: '',
          name: appleLogin.familyName ?? "");
    } on Exception {
      return SocialLoginResult(
        status: false,
        message: 'Something Went Wrong',
      );
    }
  }

  //google login
  Future<SocialLoginResult> googleLogin() async {
    try {
      await googleSignIn?.signOut();
      googleSignIn = GoogleSignIn.standard(scopes: const ['email']);
      final GoogleSignInAccount? account = await googleSignIn?.signIn();

      if (account == null) {
        // User canceled the login process
        return SocialLoginResult(
          status: false,
          message: 'Sign in aborted by user',
        );
      }

      log("Google account email: ${account.email}");

      return SocialLoginResult(
        message: 'You have successfully Logged In',
        status: await googleSignIn?.isSignedIn() ?? false,
        socialType: 'Google',
        emailAddress: account.email,
        socialId: account.id,
        image: account.photoUrl ?? "",
        name: account.displayName ?? "",
      );
    } catch (e) {
      log(e.toString());
      return SocialLoginResult(
        status: false,
        message: 'Error during Google sign-in: $e',
      );
    }
  }

  //facebook login

  Future<SocialLoginResult> facebookLogin() async {
    try {
      FacebookAuth.instance.logOut();
      LoginResult loginResult = await FacebookAuth.instance
          .login(permissions: ["email", "public_profile"]);
      final userData = await FacebookAuth.instance.getUserData();

      if (loginResult.status == LoginStatus.success) {
        return SocialLoginResult(
            message: 'You have successfully Logged In',
            status: loginResult.status == LoginStatus.success,
            socialType: 'Facebook',
            emailAddress: userData['email'],
            socialId: userData['id'],
            image: userData['picture']['data']['url'],
            name: userData['name']);
      } else {
        return SocialLoginResult(
            message: 'Something went wrong',
            status: false,
            socialType: null,
            emailAddress: null,
            socialId: null,
            image: null,
            name: null);
      }
    } on Exception catch (e) {
      log(e.toString());
      return SocialLoginResult(
        status: false,
        message: 'Something Went Wrong $e',
      );
    }
  }

  Future<void> signOutGoogle() async {
    final isLoggedIn = await googleSignIn?.isSignedIn();
    if ((isLoggedIn) == true) {
      await googleSignIn?.signOut();
    }
  }

  Future<void> fbSignOut() async {
    await FacebookAuth.instance.logOut();
  }
}
