// ignore_for_file: require_trailing_commas, lines_longer_than_80_chars

import 'package:authentication_client/authentication_client.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_authentication_client/firebase_authentication_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:token_storage/token_storage.dart';

import 'firebase_authentication_client_test.mocks.dart';

@GenerateMocks([
  TokenStorage,
  firebase_auth.FirebaseAuth,
  firebase_auth.User,
  firebase_auth.UserCredential,
  firebase_auth.AuthCredential,
  firebase_auth.UserMetadata, 
  GoogleSignIn,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
])
void main() {
  // testing data
  const testEmail = 'test@example.com';
  const testPassword = 'password123';
  const testUid = 'testuid';
  const testDisplayName = 'Test User';
  const testNewEmail = 'new@example.com';

  late FirebaseAuthenticationClient authenticationClient;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockTokenStorage mockTokenStorage;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockTokenStorage = MockTokenStorage();

    when(mockFirebaseAuth.userChanges())
        .thenAnswer((_) => const Stream.empty());

    authenticationClient = FirebaseAuthenticationClient(
      firebaseAuth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
      tokenStorage: mockTokenStorage,
    );
  });

  group('FirebaseAuthenticationClient', () {
    group('logInWithGoogle', () {
      test('successfully logs in with Google', () async {
        // Arrange
        final mockGoogleUser = MockGoogleSignInAccount();
        final mockGoogleAuth = MockGoogleSignInAuthentication();
        final mockUserCredential = MockUserCredential();
        final mockUser = MockUser();
        final mockUserMetadata = MockUserMetadata();

        when(mockGoogleSignIn.signIn())
            .thenAnswer((_) async => mockGoogleUser);
        when(mockGoogleUser.authentication)
            .thenAnswer((_) async => mockGoogleAuth);
        when(mockGoogleAuth.accessToken).thenReturn('accessToken');
        when(mockGoogleAuth.idToken).thenReturn('idToken');

        when(mockFirebaseAuth.signInWithCredential(any))
            .thenAnswer((_) async => mockUserCredential);

        when(mockUserCredential.user).thenReturn(mockUser);
        when(mockUser.uid).thenReturn(testUid);
        when(mockUser.email).thenReturn(testEmail);
        when(mockUser.displayName).thenReturn(testDisplayName);

        when(mockUser.metadata).thenReturn(mockUserMetadata);
        when(mockUserMetadata.creationTime)
            .thenReturn(DateTime.now().subtract(const Duration(days: 365)));
        when(mockUserMetadata.lastSignInTime).thenReturn(DateTime.now());

        when(mockFirebaseAuth.userChanges())
            .thenAnswer((_) => Stream.value(mockUser));

        // Act
        await authenticationClient.logInWithGoogle();

        // Assert
        final user = await authenticationClient.user.first;
        expect(user.isAnonymous, isFalse);
        expect(user.email, testEmail);
        expect(user.id, testUid);

        verify(mockFirebaseAuth.signInWithCredential(any)).called(1);
      });

      test('throws LogInWithGoogleCanceled when user cancels', () async {
        // Arrange
        when(mockGoogleSignIn.signIn()).thenAnswer((_) async => null);

        // Act & Assert
        await expectLater(
          authenticationClient.logInWithGoogle(),
          throwsA(isA<LogInWithGoogleCanceled>()),
        );
      });

      test('throws LogInWithGoogleFailure on exception', () async {
        // Arrange
        when(mockGoogleSignIn.signIn())
            .thenThrow(Exception('Sign in error'));

        // Act & Assert
        await expectLater(
          authenticationClient.logInWithGoogle(),
          throwsA(isA<LogInWithGoogleFailure>()),
        );
      });
    });

    group('logOut', () {
      test('successfully logs out', () async {
        
        // Arrange
        when(mockFirebaseAuth.signOut()).thenAnswer((_) async {});
        when(mockGoogleSignIn.signOut()).thenAnswer((_) async => null);
        when(mockFirebaseAuth.userChanges())
            .thenAnswer((_) => Stream.value(null));

        // Act
        await authenticationClient.logOut();

        // Assert
        verify(mockFirebaseAuth.signOut()).called(1);
        verify(mockGoogleSignIn.signOut()).called(1);
        
        final user = await authenticationClient.user.first;
        expect(user.isAnonymous, isTrue);
      });

      test('throws LogOutFailure on exception', () async {
        // Arrange
        when(mockFirebaseAuth.signOut()).thenThrow(Exception('Logout error'));

        // Act & Assert
        await expectLater(
          authenticationClient.logOut(),
          throwsA(isA<LogOutFailure>()),
        );
      });
    });

    group('updateProfile', () {
      test('successfully updates profile', () async {
        // Arrange
        final mockUser = MockUser();
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.updateDisplayName('New Name'))
            .thenAnswer((_) async {});

        // Act
        await authenticationClient.updateProfile(username: 'New Name');

        // Assert
        verify(mockUser.updateDisplayName('New Name')).called(1);
      });

      test('throws UpdateProfileFailure on exception', () async {
        // Arrange
        final mockUser = MockUser();
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.updateDisplayName('New Name'))
            .thenThrow(Exception('Update error'));

        // Act & Assert
        await expectLater(
          authenticationClient.updateProfile(username: 'New Name'),
          throwsA(isA<UpdateProfileFailure>()),
        );
      });
    });

    group('updateEmail', () {
      test('successfully updates email', () async {
        // Arrange
        final mockUser = MockUser();

        final mockUserCredential = MockUserCredential();

        when(mockUser.email).thenReturn(testEmail);
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

        // match the AuthCredential by its properties
        when(mockUser.reauthenticateWithCredential(argThat(
          predicate((credential) =>
              credential is firebase_auth.EmailAuthCredential &&
              credential.email == testEmail &&
              credential.password == testPassword),
        ))).thenAnswer((_) async => mockUserCredential);

        when(mockUser.verifyBeforeUpdateEmail(testNewEmail))
            .thenAnswer((_) async => Future.value());

        // Act
        await authenticationClient.updateEmail(
          email: testNewEmail,
          password: testPassword,
        );

        // Assert
        verify(mockUser.reauthenticateWithCredential(argThat(
          predicate((credential) =>
              credential is firebase_auth.EmailAuthCredential &&
              credential.email == testEmail &&
              credential.password == testPassword),
        ))).called(1);
        verify(mockUser.verifyBeforeUpdateEmail(testNewEmail)).called(1);
      });

      test('throws UpdateEmailFailure when currentUser is null', () async {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(null);

        // Act & Assert
        await expectLater(
          authenticationClient.updateEmail(
            email: testNewEmail,
            password: testPassword,
          ),
          throwsA(isA<UpdateEmailFailure>()),
        );
      });

      test('throws UpdateEmailFailure on exception', () async {
        // Arrange
        final mockUser = MockUser();
        final authCredential = firebase_auth.EmailAuthProvider.credential(
          email: testEmail,
          password: testPassword,
        );
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.email).thenReturn(testEmail);
        when(mockUser.reauthenticateWithCredential(authCredential))
            .thenThrow(Exception('Reauth error'));

        // Act & Assert
        await expectLater(
          authenticationClient.updateEmail(
            email: testNewEmail,
            password: testPassword,
          ),
          throwsA(isA<UpdateEmailFailure>()),
        );
      });
    });

    group('deleteAccount', () {
      test('successfully deletes account', () async {
        // Arrange
        final mockUser = MockUser();
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.delete()).thenAnswer((_) async {});

        // Act
        await authenticationClient.deleteAccount();

        // Assert
        verify(mockUser.delete()).called(1);
      });

      test('throws DeleteAccountFailure when currentUser is null', () async {
        // Arrange
        when(mockFirebaseAuth.currentUser).thenReturn(null);

        // Act & Assert
        await expectLater(
          authenticationClient.deleteAccount(),
          throwsA(isA<DeleteAccountFailure>()),
        );
      });

      test('throws DeleteAccountFailure on exception', () async {
        // Arrange
        final mockUser = MockUser();
        when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
        when(mockUser.delete()).thenThrow(Exception('Delete error'));

        // Act & Assert
        await expectLater(
          authenticationClient.deleteAccount(),
          throwsA(isA<DeleteAccountFailure>()),
        );
      });
    });

    group('logInWithPassword', () {
      test('successfully logs in with password', () async {
        // Arrange
        final mockUserCredential = MockUserCredential();
        when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        )).thenAnswer((_) async => mockUserCredential);

        // Act
        await authenticationClient.logInWithPassword(
          email: testEmail,
          password: testPassword,
        );

        // Assert
        verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        )).called(1);
      });

      test('throws LogInWithPasswordFailure on exception', () async {
        // Arrange
        when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        )).thenThrow(Exception('Login error'));

        // Act & Assert
        await expectLater(
          authenticationClient.logInWithPassword(
            email: testEmail,
            password: testPassword,
          ),
          throwsA(isA<LogInWithPasswordFailure>()),
        );
      });
    });

    group('signUpWithPassword', () {
      test('successfully signs up with password', () async {
        // Arrange
        final mockUserCredential = MockUserCredential();
        final mockUser = MockUser();
        when(mockUserCredential.user).thenReturn(mockUser);
        when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        )).thenAnswer((_) async => mockUserCredential);
        when(mockUser.updateProfile(
          displayName: testDisplayName,
        )).thenAnswer((_) async {});

        // Act
        await authenticationClient.signUpWithPassword(
          email: testEmail,
          password: testPassword,
          username: testDisplayName,
        );

        // Assert
        verify(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        )).called(1);
        verify(mockUser.updateProfile(
          displayName: testDisplayName,
        )).called(1);
      });

      test('throws SignUpWithPasswordFailure when user is null', () async {
        // Arrange
        final mockUserCredential = MockUserCredential();
        when(mockUserCredential.user).thenReturn(null);
        when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        )).thenAnswer((_) async => mockUserCredential);

        // Act & Assert
        await expectLater(
          authenticationClient.signUpWithPassword(
            email: testEmail,
            password: testPassword,
            username: testDisplayName,
          ),
          throwsA(isA<SignUpWithPasswordFailure>()),
        );
      });

      test('throws SignUpWithPasswordFailure on exception', () async {
        // Arrange
        when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        )).thenThrow(Exception('Signup error'));

        // Act & Assert
        await expectLater(
          authenticationClient.signUpWithPassword(
            email: testEmail,
            password: testPassword,
            username: testDisplayName,
          ),
          throwsA(isA<SignUpWithPasswordFailure>()),
        );
      });
    });
  });
}
