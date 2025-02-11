String mapFirebaseAuthExceptionCodes(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return 'The email address is not valid.';
    case 'user-disabled':
      return 'The user corresponding to the given email has been disabled.';
    case 'user-not-found':
      return 'No user corresponding to the given email was found.';
    case 'wrong-password':
      return 'The password is invalid or the account does not have a password set.';
    case 'email-already-in-use':
      return 'The email address is already in use by another account.';
    case 'operation-not-allowed':
      return 'Sign-in with this method is not enabled.';
    case 'weak-password':
      return 'The provided password is too weak.';
    case 'too-many-requests':
      return 'Too many attempts. Try again later.';
    case 'network-request-failed':
      return 'Network error occurred. Check your internet connection.';
    case 'invalid-credential':
      return 'The supplied credential is incorrect or expired.';
    case 'account-exists-with-different-credential':
      return 'An account already exists with the same email but different sign-in credentials.';
    case 'invalid-verification-code':
      return 'The verification code is invalid or expired.';
    case 'invalid-verification-id':
      return 'The verification ID is invalid.';
    case 'provider-already-linked':
      return 'The account is already linked with this provider.';
    case 'credential-already-in-use':
      return 'This credential is already linked to a different user account.';
    case 'requires-recent-login':
      return 'This operation is sensitive and requires recent authentication. Please log in again.';
    case 'missing-verification-code':
      return 'A verification code is required.';
    case 'missing-verification-id':
      return 'A verification ID is required.';
    case 'session-expired':
      return 'The authentication session has expired. Please try again.';
    case 'quota-exceeded':
      return 'Quota for this operation has been exceeded. Try again later.';
    case 'internal-error':
      return 'An internal error occurred. Try again later.';
    default:
      return 'An unknown error occurred. Please try again later.';
  }
}
