import 'dart:io';

import 'package:get_storage/get_storage.dart';

class SharedPrefs {
  SharedPrefs._privateConstructor();

  static final SharedPrefs _instance = SharedPrefs._privateConstructor();

  factory SharedPrefs() {
    return _instance;
  }

  final _box = GetStorage();
  static const _accessToken = '_accessToken';
  static const _verifyOrganization = '_checkOrganization';
  static const _username = '_username';
  static const _refreshToken = '_refreshToken';
  static const _id = '_id';
  static const _tokenId = '_tokenId';
  static const _onBoardingKey = '_onBoardingKey';
  static const _language = 'language';
  static const _fullName = '_fullName';
  static const _cityName = '_cityName';
  static const _cityId = '_cityId';
  static const _email = '_email';
  static const _password = '_password';
  static const _googleAuth = '_googleAuth';
  static const _lightTheme = '_lightTheme';
  static const _setThemeAuto = '_setThemeAuto';
  static const _authByBiometrics = '_authByBiometrics';

  dynamic _getValue(String key) {
    return _box.read(key);
  }

  void _setValue(String key, dynamic value) {
    _box.write(key, value);
  }

  void _removePref() {
    _box.remove(_accessToken);
    _box.remove(_username);
    _box.remove(_verifyOrganization);
    _box.remove(_refreshToken);
    _box.remove(_id);
    _box.remove(_fullName);
    _box.remove(_cityName);
    _box.remove(_tokenId);
  }

  void setAccessToken(String? value) {
    if (value == null) return;
    _setValue(_accessToken, value);
  }

  void setGroupAndUser({String? username, String? group}) {
    if (group == null && username == null) return;
    _setValue(_username, username);
  }


  void setVerifyOrganization(bool value) {
    _setValue(_verifyOrganization, value);
  }

  String? getAccessToken() {
    return _getValue(_accessToken);
  }

  bool? getVerifyOrganization() {
    return _getValue(_verifyOrganization);
  }

  String? getUsername() {
    return _getValue(_username);
  }

  void setRefreshToken(String? value) {
    if (value == null) return;
    _setValue(_refreshToken, value);
  }

  String? getRefreshToken() {
    return _getValue(_refreshToken);
  }

  void setLocaleLang(String value) async {
    _setValue(_language, value);
  }

  String getLocaleLang() {
    return _getValue(_language) ?? getLocale();
  }

  void setSeenOnBoarding([isSeen = true]) {
    _setValue(_onBoardingKey, isSeen);
  }

  bool? getOnBoardingState() {
    return _getValue(_onBoardingKey);
  }

  void setId(String? id) {
    _setValue(_id, id);
  }

  String? getId() {
    return _getValue(_id);
  }

  void setTokenId(int? name) {
    _setValue(_tokenId, name);
  }

  int? getTokenId() {
    return _getValue(_tokenId);
  }

  void setFullName(String? name) {
    _setValue(_fullName, name);
  }

  String? getFullName() {
    return _getValue(_fullName);
  }


  String? getPassword() {
    return _getValue(_password);
  }

  void setPassword(String? value) {
    _setValue(_password, value);
  }

  void setCityName(String? value) {
    _setValue(_cityName, value);
  }

  void setCityId(int? value) {
    _setValue(_cityId, value);
  }

  String? getCityName() {
    return _getValue(_cityName);
  }

  int? getCityId() {
    return _getValue(_cityId);
  }

  void setEmail(String? value) {
    _setValue(_email, value);
  }

  String? getEmail() {
    return _getValue(_email);
  }

  void setCode(String? value) {
    _setValue(_password, value);
  }

  String? getCode() {
    return _getValue(_password);
  }

  void authViaGoogle() {
    _setValue(_googleAuth, true);
  }

  bool isAuthViaGoogle() => _getValue(_googleAuth) ?? false;

  void setLightTheme([bool v = true]) => _setValue(_lightTheme, v);

  bool? isLightTheme() => _getValue(_lightTheme);

  void setThemeAuto([bool v = true]) => _setValue(_setThemeAuto, v);

  bool isThemeAuto() => _getValue(_setThemeAuto) ?? false;

  void deleteTokens() => _removePref();

  String getLocale() {
    String locale = 'kk';
    final systemLocale = Platform.localeName;
    final filteredLocale = systemLocale.split('_')[0];

    if (filteredLocale == 'ru') {
      locale = 'ru';
    } else if (filteredLocale == 'en') {
      locale = 'en';
    } else {
      locale = 'kk';
    }
    return locale;
  }

  bool isAuthByBiometrics() => _getValue(_authByBiometrics) ?? false;

  void authByBiometrics(bool value) => _setValue(_authByBiometrics, value);
}
