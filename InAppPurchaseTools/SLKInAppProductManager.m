//
//  SLKInAppProductManager.m
//  InAppPurchaseTools
//
//  Created by Ben DiFrancesco on 12/11/14.
//  Copyright (c) 2014 Scope Lift. All rights reserved.
//

#import "SLKInAppProductManager.h"
#import <StoreKit/StoreKit.h>

@interface SLKInAppProductManager () <SKProductsRequestDelegate>
@end

@implementation SLKInAppProductManager
{
    
SKProductsRequest * _productsRequest;
RequestProductsCompletionHandler _completionHandler;
NSSet * _productIdentifiers;
    
}

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers {
    
    if ((self = [super init])) {
        
        // Store product identifiers
        _productIdentifiers = productIdentifiers;
        
    }
    return self;
}

- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler {
    
    _completionHandler = [completionHandler copy];

    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:_productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
    
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    //NSLog(@"Loaded list of products...");
    _productsRequest = nil;
    
    NSArray * skProducts = response.products;
    NSMutableArray *skProductIds = [[NSMutableArray alloc] initWithCapacity:3];
    
    for (SKProduct * skProduct in skProducts) {
        //NSLog(@"Found product: %@ %@ %0.2f", skProduct.productIdentifier, skProduct.localizedTitle, skProduct.price.floatValue);
        
        [skProductIds addObject:skProduct.productIdentifier];
    }
    
    NSDictionary *skProductDictionary = [NSDictionary dictionaryWithObjects:skProducts forKeys:skProductIds];
    
    _completionHandler(YES, skProductDictionary);
    _completionHandler = nil;
    
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    //NSLog(@"Failed to load list of products: %@", error);
    _productsRequest = nil;
    
    _completionHandler(NO, nil);
    _completionHandler = nil;
    
}

@end
