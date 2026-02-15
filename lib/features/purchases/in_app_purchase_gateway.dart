import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

import 'purchase_gateway.dart';

class InAppPurchaseGateway implements PurchaseGateway {
  InAppPurchaseGateway({
    required String productId,
    InAppPurchase? iap,
  })  : _productId = productId,
        _iap = iap ?? InAppPurchase.instance;

  final String _productId;
  final InAppPurchase _iap;

  @override
  Future<bool> restorePurchases() async {
    final isAvailable = await _iap.isAvailable();
    if (!isAvailable) {
      return false;
    }

    final completer = Completer<bool>();
    late final StreamSubscription<List<PurchaseDetails>> subscription;
    subscription = _iap.purchaseStream.listen((purchases) async {
      for (final purchase in purchases) {
        final isTarget = purchase.productID == _productId;
        final isRestored = purchase.status == PurchaseStatus.restored;
        final isPurchased = purchase.status == PurchaseStatus.purchased;
        if (isTarget && (isRestored || isPurchased)) {
          if (purchase.pendingCompletePurchase) {
            await _iap.completePurchase(purchase);
          }
          if (!completer.isCompleted) {
            completer.complete(true);
          }
          return;
        }
      }
    });

    await _iap.restorePurchases();
    final restored = await completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () => false,
    );
    await subscription.cancel();
    return restored;
  }
}
