# Amazon Appstore IAP Sample in Flutter

This project is a sample Flutter App to showcase how you can use [Amazon Appstore IAP](https://developer.amazon.com/docs/in-app-purchasing/iap-get-started.html)
in your [Flutter](https://flutter.dev/) project using the [plugin from Dooboolab](https://github.com/dooboolab/flutter_inapp_purchase)

## Prerequisites

To run the app an test it with the Amazon Appstore, you will need the following:
- [Flutter SDK installed](https://docs.flutter.dev/get-started/install)
- Your favourite IDE
- [An Amazon Appstore developer account](https://developer.amazon.com/apps-and-games)
- An Amazon Fire device
  
## ✅ Features

<p align="center">
<img src="https://github.com/AmazonAppDev/flutter-amazon-iap-demo/blob/main/images/homelocked.png?raw=true" width=50% height=50%>
</p>

The project is about a fictional music app *GIOLAQ Music* ( **Note:** I'm not an actual singer 👨‍🎤 )

**What you can purchase:**
- The right to play the whole album of GIOLAQ
- The yearly subscription to all the music produced by GIOLAQ
- Tickets granting you access to GIOLAQ live music concerts (one ticket per concert)

These three in-app purchases correspond respectively to the three types of IAP
supported by the Amazon Appstore:

- **Consumables:** Purchase that is made, then consumed within the app, such as extra lives, extra moves, or in-game currency. May be purchased multiple times.
- **Entitlements:** One-time purchase to unlock access to features or content within an app or game.
- **Subscriptions:** Offers access to a premium set of content or features for a limited period of time.

**Note:** Make sure to review our [docs on IAP for Amazon Appstore](https://developer.amazon.com/docs/in-app-purchasing/iap-overview.html).

## 💻 Building the Amazon Appstore IAP Sample in Flutter

1. Clone the following repository: `git clone https://github.com/AmazonAppDev/flutter-amazon-iap-demo`

2. Create the following IAP items on the Amazon Appstore console:
      1. A subscription item with SKU `dev.giolaq.oneyear`
      2. An entitlement item with SKU `dev.giolaq.album`
      3. A consumable item with SKU `dev.giolaq.live`
3. To create the IAP items follow the instructions [here](https://developer.amazon.com/docs/in-app-purchasing/iap-create-and-submit-iap-items.html#create-new-in-app-items)
   or in [this video](https://www.youtube.com/watch?v=cmPAY16wGb0)
4. Download the IAP item json file from the Amazon Appstore console, instructions [here](https://www.youtube.com/watch?v=cmPAY16wGb0&t=289s)
5. Upload the json file to the Fire Tablet using this command from the terminal
   ```sh
    adb push <_Your_JSON_File_Folder_>/amazon.sdktester.json /sdcard/amazon.sdktester.json
   ```
6. Enable the Sandbox mode to test with virtual purchases (No real 💸 spent) using this command
   ```sh
   adb shell setprop debug.amazon.sandboxmode debug
   ```
7. Install the [IAP app tester](https://www.amazon.com/Amazon-App-Tester/dp/B00BN3YZM2) from the Amazon appstore. 
8. Build and run the Flutter app from your IDE setting as a target your Fire Tablet device.

## Using the Sample App
At first launch, you will see the music page without a Play button since there are no purchases yet.

Head to purchase page to purchase one of the three different IAP items:
- Music Album
- Yearly subscription
- Ticket

Music Album and Yearly subscription will unlock the music in the music screen.

Ticket will increase the ticket counter in the music screen
You can consume the ticket tapping on the ticket icon

## Get support

If you have questions, comments, or need help with code, we're here to help:
- [Ask questions](https://community.amazondeveloper.com/c/amazon-appstore/appstore-questions/20) in the Amazon developer community space
- Ask questions on Stack Overflow using the [amazon-appstore](https://stackoverflow.com/questions/tagged/amazon-appstore) tag

Sign up to [stay updated with the developer newsletter](https://m.amazonappservices.com/subscribe-newsletter).

## Authors

- [@giolaq](https://twitter.com/giolaq)
