import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/models/user.dart';

/// Wrapper do Google Sign-In.
class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<User?> signIn() async {
    final account = await _googleSignIn.signIn();
    if (account == null) return null;

    return User(
      id: account.id,
      name: account.displayName ?? 'Usuário',
      email: account.email,
      photoUrl: account.photoUrl,
    );
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  Future<User?> getCurrentUser() async {
    final account = _googleSignIn.currentUser;
    if (account == null) return null;

    return User(
      id: account.id,
      name: account.displayName ?? 'Usuário',
      email: account.email,
      photoUrl: account.photoUrl,
    );
  }
}
