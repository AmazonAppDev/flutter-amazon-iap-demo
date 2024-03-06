// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class IAPConnection {
  static FlutterInappPurchase? _instance;

  static set instance(FlutterInappPurchase value) {
    _instance = value;
  }

  static FlutterInappPurchase get instance {
    if (_instance == null) {
      FlutterInappPurchase.instance.initialize();
      _instance = FlutterInappPurchase.instance;
    }
    return _instance!;
  }
}

class IapHandler extends ChangeNotifier {
  late StreamSubscription _connectionSubscription;
  late StreamSubscription _purchaseUpdatedSubscription;
  late StreamSubscription _purchaseErrorSubscription;

  List<IAPItem> items = [];
  List<PurchasedItem> purchases = [];
  int liveTicketsPurchased = 0;

  final List<String> _productLists = [
    'dev.giolaq.oneyear',
    'dev.giolaq.album',
    'dev.giolaq.live'
  ];
  final iapConnection = IAPConnection.instance;

  IapHandler() {
    refreshItemForAndroid();
    initSubscriptions();
    loadPurchases();
  }

  void initSubscriptions() {
     _connectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
          print('connected: $connected');
        });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {
          _purchasesUpdate(productItem!);
          _updateStreamOnDone();
        });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
          _updateStreamOnError(purchaseError);
        });
  }

  Future<void> loadPurchases() async {
    items = await FlutterInappPurchase.instance.getProducts(_productLists);
    notifyListeners();
  }

  Future<void> refreshItemForAndroid() async {
    try {
      String msg = await FlutterInappPurchase.instance.consumeAll();
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    _purchaseUpdatedSubscription.cancel();
    _purchaseErrorSubscription.cancel();
    super.dispose();
  }

  Future<void> buy(IAPItem product) async {
    iapConnection.requestPurchase(product.productId!);
  }

  void _updateStreamOnDone() {
    _connectionSubscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    // ignore: avoid_print
    print(error);
  }

  void _purchasesUpdate(PurchasedItem purchase) {
    purchases.add(purchase);
    if (purchase.productId == "dev.giolaq.live") {
      liveTicketsPurchased++;
    }
    notifyListeners();
  }

  void consume(PurchasedItem purchase) {
    final int item = purchases
        .indexWhere((element) => element.productId == purchase.productId);
    purchases.removeAt(item);
    liveTicketsPurchased--;
    notifyListeners();
  }
}
