//
//  SLKInAppProductManager.h
//  InAppPurchaseTools
//
//  Created by Ben DiFrancesco on 12/11/14.
//  Copyright (c) 2014 Scope Lift. All rights reserved.
//
// Uses the code from the following Ray Wenderlich tutorial as a starting point
// Strips out code related to *purchasing* of IAPs and implements a simplified
// Singleton design for accessing IAP product info
//
// http://www.raywenderlich.com/21081/introduction-to-in-app-purchases-in-ios-6-tutorial

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

UIKIT_EXTERN NSString *const SLKInAppProductManagerProductsDidLoad;
UIKIT_EXTERN NSString *const SLKInAppProductManagerProductLoadFailed;

@interface SLKInAppProductManager : NSObject

@property (strong, nonatomic) NSDictionary *skProductDictionary;

+ (SLKInAppProductManager *)manager;
- (void)loadProductsWithIdentifiers:(NSString *)firstIdentifier, ... ;

@end
