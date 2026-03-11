import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseService extends ChangeNotifier {
  static final PurchaseService _instance = PurchaseService._internal();
  factory PurchaseService() => _instance;
  PurchaseService._internal();

  bool _isPremium = false;
  bool get isPremium => _isPremium;

  Future<void> init(String appleApiKey, String googleApiKey) async {
    if (kIsWeb) {
      // RevenueCat does not support Flutter Web directly for IAPs.
      // For web testing, we start as non-premium.
      _isPremium = false;
      notifyListeners();
      return;
    }

    await Purchases.setLogLevel(LogLevel.debug);

    PurchasesConfiguration? configuration;
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      if (appleApiKey.isNotEmpty) {
        configuration = PurchasesConfiguration(appleApiKey);
      }
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      if (googleApiKey.isNotEmpty) {
        configuration = PurchasesConfiguration(googleApiKey);
      }
    }

    if (configuration != null) {
      await Purchases.configure(configuration);
      await _checkEligibility();
    }
  }

  Future<void> _checkEligibility() async {
    try {
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      // 'premium_access' is the specific Entitlement ID we'll configure in RevenueCat
      _isPremium =
          customerInfo.entitlements.all['premium_access']?.isActive == true;
      notifyListeners();
    } catch (e) {
      debugPrint("Failed to get customer info: $e");
    }
  }

  /// Attempts to purchase the first available package in the Current Offering.
  Future<bool> purchasePremium() async {
    if (kIsWeb) {
      // Mock purchase for web testing
      await Future.delayed(const Duration(seconds: 1));
      _isPremium = true;
      notifyListeners();
      return true;
    }

    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null &&
          offerings.current!.availablePackages.isNotEmpty) {
        // ignore: deprecated_member_use
        await Purchases.purchasePackage(
          offerings.current!.availablePackages.first,
        );
        CustomerInfo customerInfo = await Purchases.getCustomerInfo();
        _isPremium =
            customerInfo.entitlements.all['premium_access']?.isActive == true;
        notifyListeners();
        return _isPremium;
      } else {
        debugPrint("No packages available to purchase.");
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        debugPrint("Purchase failed: $e");
      }
    } catch (e) {
      debugPrint("Failed to purchase: $e");
    }
    return false;
  }

  Future<bool> restorePurchases() async {
    if (kIsWeb) return false;

    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      _isPremium =
          customerInfo.entitlements.all['premium_access']?.isActive == true;
      notifyListeners();
      return _isPremium;
    } catch (e) {
      debugPrint("Failed to restore: $e");
    }
    return false;
  }
}
