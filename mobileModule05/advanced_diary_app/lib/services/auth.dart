import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static User? get currentUser => _firebaseAuth.currentUser;
  static Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await _firebaseAuth.signInWithCredential(credential);
  }

  static Future<UserCredential> signInWithGitHub() async {
    GithubAuthProvider githubProvider = GithubAuthProvider();
    return await _firebaseAuth.signInWithProvider(githubProvider);
  }

  static Future<void> sigOut() async {
    await _firebaseAuth.signOut();
    if (currentUser != null) {
      final providers = currentUser?.providerData;
      if (providers != null &&
          providers.any((provider) => provider.providerId == "google.com")) {
        await GoogleSignIn().disconnect();
      }
    }
  }
}
