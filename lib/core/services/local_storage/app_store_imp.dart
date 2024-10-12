import 'package:recruitment_test_website/core/services/local_storage/app_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorageImp extends AppStorageI {
  static Future<SharedPreferences> getPrefs() async {
    return SharedPreferences.getInstance();
  }

  static const String _keyBearerToken = 'bearer_token';
  static const String _keyUserEmail = 'user_email';
  static const String _keyPassword = 'password';
  static const String _keyUserId = 'user_id';
  static const String _keyFullName = 'full_name';

  @override
  Future<void> storeBearerToken(String token) async {
    final prefs = await getPrefs();
    await prefs.setString(_keyBearerToken, token);
  }

  @override
  Future<String?> retrieveBearerToken() async {
    final prefs = await getPrefs();
    return prefs.getString(_keyBearerToken);
  }

  @override
  Future<void> clearBearerToken() async {
    final prefs = await getPrefs();
    await prefs.remove(_keyBearerToken);
  }

  @override
  Future<Map<String, dynamic>?> retrieveCredentials() async {
    final prefs = await getPrefs();
    final userEmail = prefs.getString(_keyUserEmail);
    final password = prefs.getString(_keyPassword);

    if (userEmail != null && password != null) {
      return {'userEmail': userEmail, 'password': password};
    }

    return null;
  }

  @override
  Future<void> storeCredentials(Map<String, dynamic> credentials) async {
    final prefs = await getPrefs();

    final String userEmail = credentials['userEmail'];
    final String password = credentials['password'];

    await prefs.setString(_keyUserEmail, userEmail);
    await prefs.setString(_keyPassword, password);
  }

  @override
  Future<void> clearCredentials() async {
    final prefs = await getPrefs();

    await prefs.remove(_keyUserEmail);
    await prefs.remove(_keyPassword);
  }

  @override
  Future<void> storeProfileId(String id) async {
    final prefs = await getPrefs();
    final userId = id;
    await prefs.setString(_keyUserId, userId);
  }

  @override
  Future<String?> retrieveUserID() async {
    final prefs = await getPrefs();

    return prefs.getString(_keyUserId);
  }

  @override
  Future<void> clearProfileId() async {
    final prefs = await getPrefs();
    await prefs.remove(_keyUserId);
  }

  @override
  Future<void> storeFullName(String firstName, String lastName) async {
    final prefs = await getPrefs();
    await prefs.setString(_keyFullName, '$firstName $lastName');
  }

  @override
  Future<String?> retrieveFullName() async {
    final prefs = await getPrefs();
    return prefs.getString(_keyFullName);
  }

  @override
  Future<void> clearFullName() async {
    final prefs = await getPrefs();
    await prefs.remove(_keyFullName);
  }
}
