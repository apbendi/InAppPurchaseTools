//
//  SLKInAppProductManager.h
//  InAppPurchaseTools
//
//  Created by Ben DiFrancesco on 12/11/14.
//  Copyright (c) 2014 Scope Lift. All rights reserved.
//
// Uses the code from the following Ray Wenderlich tutorial as a starting point
// Strips out code related to *purchasing* of IAPs and implements a simplified
// Singleton design

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

UIKIT_EXTERN NSString *const IAPHelperProductPurchasedNotification;
UIKIT_EXTERN NSString *const IAPHelperProductPurchaseFailedNotification;

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSDictionary * products);

@interface SLKInAppProductManager : NSObject

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;
- (void)buyProduct:(SKProduct *)product;
- (BOOL)productPurchased:(NSString *)productIdentifier;
- (void)restoreCompletedTransactions;

@end
