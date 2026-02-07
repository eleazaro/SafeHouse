import '../../domain/models/user.dart';
import '../services/auth_service.dart';

/// Repositório de autenticação.
/// Na v1, usa mock que sempre sucede.
abstract class AuthRepository {
  Future<User?> signInWithGoogle();
  Future<void> signOut();
  User? get currentUser;
  bool get isAuthenticated;
}

/// Implementação mock — login sempre sucede com user fake.
/// Ideal para desenvolvimento sem Firebase configurado.
class MockAuthRepository implements AuthRepository {
  User? _currentUser;

  @override
  Future<User?> signInWithGoogle() async {
    await Future.delayed(const Duration(milliseconds: 800));
    _currentUser = const User(
      id: 'mock-user-1',
      name: 'João Silva',
      email: 'joao@safehouse.com',
      photoUrl: null,
    );
    return _currentUser;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  @override
  User? get currentUser => _currentUser;

  @override
  bool get isAuthenticated => _currentUser != null;
}

/// Implementação real com Google Sign-In.
/// Usar quando Firebase estiver configurado.
class GoogleAuthRepository implements AuthRepository {
  final AuthService _authService;
  User? _currentUser;

  GoogleAuthRepository(this._authService);

  @override
  Future<User?> signInWithGoogle() async {
    _currentUser = await _authService.signIn();
    return _currentUser;
  }

  @override
  Future<void> signOut() async {
    await _authService.signOut();
    _currentUser = null;
  }

  @override
  User? get currentUser => _currentUser;

  @override
  bool get isAuthenticated => _currentUser != null;
}
