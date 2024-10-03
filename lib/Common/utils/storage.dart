import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class StorageServices {
  late final SharedPreferences _pref;

  Future<StorageServices> init() async {
    _pref = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async {
    return await _pref.setString(key, value);
  }

  String getString(String key) {
    return _pref.getString(key) ?? " ";
  }

  Future<bool> setBool(String key, bool value) async {
    return await _pref.setBool(key, value);
  }

  bool getUserRegisteredEarlier() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.userRegisteredEarlier) ?? false;
  }

  bool getLogisticVerifiedEarlier() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.logisticVerified) ?? false;
  }

  bool getUserLoggedInEarlier() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.userLoggedInEarlier) ?? false;
  }

  bool getKycDoneEarlier() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.kycDone) ?? false;
  }

  bool getImageDone() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.isImageDone) ?? false;
  }

  bool getDocumentDone() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.isDocumentDone) ?? false;
  }

  bool getUserNumberSet() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.userNumberSet) ?? false;
  }

  bool getLogisticAvailable() {
    // give the value of bool if it has been set early and if it is not set then give false as the value
    return _pref.getBool(AppConstants.logisticAvailable) ?? false;
  }
}
