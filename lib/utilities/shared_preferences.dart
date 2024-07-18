import 'package:shared_preferences/shared_preferences.dart';

// -----------USER ID----------------------

// ----setUserID-----
Future<void> saveUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
}

// ----getUserIG------
Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
}

// ----clearUserId------
Future<void> clearUserId() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userId');
}

// -----------USERNAME----------------------

// ----setUserName-----
Future<void> saveUserName(String username) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userName', username);
}

// ----getUserName------
Future<String?> getUserName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userName');
}

// ----clearUserName------
Future<void> clearUserName() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userName');
}

// -----------First Name----------------------

// ----setFirstName-----
Future<void> saveFirstName(String firstName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('firstName', firstName);
}

// ----getFirstName------
Future<String?> getFirstName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('firstName');
}

// ----clearFirstName------
Future<void> clearFirstName() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('firstName');
}

// -----------Last Name----------------------

// ----setLastName-----
Future<void> saveLastName(String lastName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('lastName', lastName);
}

// ----getLastName------
Future<String?> getLastName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('lastName');
}

// ----clearLastName------
Future<void> clearLastName() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('lastName');
}

// -----------USER EMAIL----------------------

// ----setUserEmail-----
Future<void> saveUserEmail(String userEmail) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userEmail', userEmail);
}

// ----getUserEmail------
Future<String?> getUserEmail() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userEmail');
}

// ----clearUserEmail------
Future<void> clearUserEmail() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userEmail');
}

// -----------USER GENDER----------------------

// ----setUserGender-----
Future<void> saveUserGender(String userGender) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userGender', userGender);
}

// ----getUserGender------
Future<String?> getUserGender() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userGender');
}

// ----clearUserGender------
Future<void> clearUserGender() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('userGender');
}

// -----------USER IMAGE----------------------

// ----setUserImage-----
Future<void> saveUserImage(String imageURL) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('imageURL', imageURL);
}

// ----getUserImage------
Future<String?> getUserImage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('imageURL');
}

// ----clearUserImage------
Future<void> clearUserImage() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('imageURL');
}

// -----------USER TOKEN----------------------

// ----setUserToken-----
Future<void> saveUserToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

// ----getUserToken------
Future<String?> getUserToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

// ----clearUserToken------
Future<void> clearUserToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}

// -----------USER REFRESH TOKEN----------------------

// ----setUserRefreshToken-----
Future<void> saveUserRefreshToken(String refreshToken) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('refreshToken', refreshToken);
}

// ----getUserRefreshToken------
Future<String?> getUserRefreshToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('refreshToken');
}

// ----clearUserRefreshToken------
Future<void> clearUserRefreshToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('refreshToken');
}
