// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'iap_handler.dart';

class _SpendTicketWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iapHandler = context.watch<IapHandler>();
    var purchases = context.watch<IapHandler>().purchases;

    return Column(children: [
      const Text(
        "Use ticket",
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      IconButton(
        icon: const Icon(
          Icons.confirmation_number_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          iapHandler.consume(purchases
              .firstWhere((element) => element.productId == "dev.giolaq.live"));
        },
      ),
    ]);
  }
}

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    var iapHandler = context.watch<IapHandler>();
    var purchases = iapHandler.purchases;
    var liveTicketsPurchased = iapHandler.liveTicketsPurchased;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurpleAccent,
            Colors.deepPurple,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.asset(
                    'assets/io.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * .6,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  const Text(
                    "My First Music",
                    style: TextStyle(color: Colors.white, fontSize: 32.0),
                  ),
                  const Text(
                    "The Super cool Album of Giolaq",
                    style: TextStyle(
                      color: Color(0xFF16CFDE),
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 70.0,
                        icon: (() {
                          if (purchases.any((element) =>
                              element.productId == 'dev.giolaq.oneyear' ||
                              element.productId == 'dev.giolaq.album')) {
                            return const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                            );
                          } else {
                            return const Icon(
                              Icons.block,
                              color: Colors.white,
                            );
                          }
                        })(),
                        onPressed: () {},
                      ),
                      if (purchases.any((element) =>
                          element.productId == 'dev.giolaq.oneyear' ||
                          element.productId == 'dev.giolaq.album'))
                        const Text(
                          "You can enjoy Giolaq music now!",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        )
                      else
                        const Text(
                          "Buy the album or subscribe to enjoy the music",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        )
                    ],
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Column(children: [
                    const Text(
                      "Live music tickets available",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    Text(
                      "$liveTicketsPurchased",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    if (purchases.isNotEmpty) _SpendTicketWidget()
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
