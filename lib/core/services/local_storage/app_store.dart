abstract class AppStorageI {
  Future<void> storeBearerToken(String token);
  Future<String?> retrieveBearerToken();
  Future<void> clearBearerToken();

  Future<void> storeCredentials(Map<String, dynamic> credentials);
  Future<Map<String, dynamic>?> retrieveCredentials();
  Future<void> clearCredentials();

  Future<void> storeProfileId(String id);
  Future<String?> retrieveUserID();
  Future<void> clearProfileId();

  Future<void> storeFullName(String firstName, String lastName);
  Future<String?> retrieveFullName();
  Future<void> clearFullName();
}
