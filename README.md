App55 Objective-C Library
=========================

This is the App55 Objective-C Library for iOS and Mac OS X. It is used to connect to App55's systems to take payments either server-to-server or client-to-server. It should be noted that most developers using this library will be client-to-server, and as such you should NOT include your API Secret in your code. Instead initialize the gateway with just an API Key, and then send through requests as appropriate for your application.

## API Documentation

All of our API documentation is online at [https://developers.app55.com/](https://developers.app55.com). Please go there and read through to see what all the endpoints and methods in this library do.

## Run Integration Tests

After downloading this project, open it up in Xcode and select the ```app55-integration``` scheme. Click ```Edit Scheme``` and insert the following environment variables under the Arguments tab for the Run configuration:

```
APP55_API_KEY = your API key
APP55_API_SECRET = your API secret
APP55_ENVIRONMENT = Sandbox or Production depending on which environment you are connecting to (e.g. sandbox.app55.com or api.app55.com)
```

The API Key and Secret are available from the Accounts menu of the Dashboard.

## Copy Files into Your Project

Once the integration tests all pass, copy the project files from the ```app55``` group in the ```App55``` project into a group in your project (dragging and dropping from one Xcode window to the other). The files should be added to your default run target, and ARC should be enabled for these files.

## See Integration Tests for Examples

Take a look through ```app55-integration/main.m```. The method at the end controls the tests with each of the methods in the middle performing the operations on the Gateway object. See this file for examples.

## Making a Payment

The following code creates an anonymous (guest) payment using dummy card data:

```objc
A55Gateway *gateway = [A55Gateway gatewayWithEnvironment:[A55Environment environment:A55Sandbox]
                                                                              apiKey:@"YOUR_API_KEY"
                                                                           apiSecret:@"YOUR_API_SECRET"];

A55Card *card = [A55Card cardWithHolderName:@"APP55 USER"
                                     number:@"4111111111111111"
                                     expiry:@"04/2019"
                               securityCode:@"240"
                                    address:[A55Address addressWithStreet:@"8 Exchange Quay"
                                                                     city:@"Manchester"
                                                               postalCode:@"M5 3EJ"
                                                                  country:@"GB"]];


[[gateway createTransactionWithCard:[A55Card
                               user:nil
                        transaction:transaction
                          ipAddress:ipAddress] send:^(id r) {
                              ... r is a response object of type A55TransactionCreateResponse ...
                            } error:^(id error) {
                                ... error is an object of type A55Exception ...
                            }];
```
