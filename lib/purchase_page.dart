// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0
import 'package:flutter/material.dart';
import 'package:flutter_amazon_iap_demo/iap_handler.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:provider/provider.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.deepPurpleAccent,
            Colors.deepPurple,
          ]),
        ),
      ),
      SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: Column(children: [
                const SizedBox(
                  height: 50.0,
                ),
                const Text(
                  'What you can buy:',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                _PurchaseList(),
                const Padding(
                  padding: EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 0.0),
                  child: Text(
                    'What you already paid for:',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ),
                const PastPurchasesWidget(),
              ])))
    ]);
  }
}

class _PurchaseList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var purchases = context.watch<IapHandler>();
    var products = purchases.items;
    return Column(
      children: products
          .map((product) =>
          Padding(
            padding: const EdgeInsets.all(16),
            child: _PurchaseWidget(
                product: product,
                onPressed: () {
                  purchases.buy(product);
                })),
          ).toList(),
    );
  }
}

class _PurchaseWidget extends StatelessWidget {
  final IAPItem product;
  final VoidCallback onPressed;

  const _PurchaseWidget({
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var title = product.title ?? "";

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16.0),
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: onPressed,
            child: Column(
                children: <Widget>[ Text(
                  title,
                ),
                  Text(
                    product.description ?? "",
                    style: const TextStyle(
                        color: Color(0xFF16CFDE), fontSize: 15.0),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

class PastPurchasesWidget extends StatelessWidget {
  const PastPurchasesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var iapHandler = context.watch<IapHandler>();
    var purchases = iapHandler.purchases;
    var items = iapHandler.items;

    return ListView.separated(
      shrinkWrap: true,
      itemCount: purchases.length,
      itemBuilder: (context, index) =>
          ListTile(
            title: Text(items
                .firstWhere(
                    (element) =>
                purchases[index].productId!.contains(element.productId!))
                .title
                .toString()),
            subtitle: Text(items
                .firstWhere(
                    (element) =>
                        purchases[index].productId!.contains(element.productId!))                .description
                .toString()),
            onTap: () {
              if (purchases[index].productId == "dev.giolaq.live") {
                iapHandler.consume(purchases[index]);
              }
            },
          ),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
