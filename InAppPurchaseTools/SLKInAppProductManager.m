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

- (void)loadProductsWithIdentifiers:(NSString *)firstIdentifier, ...
{
    if(firstIdentifier == nil) {
        return;
    }
    
    NSMutableArray *identifiers = [[NSMutableArray alloc] init];
    
    va_list args;
    va_start(args, firstIdentifier);
    for (NSString *arg = firstIdentifier; arg != nil; arg = va_arg(args, NSString*))
    {
        [identifiers addObject:arg];
    }
    va_end(args);
    
    _productIdentifiers = [NSSet setWithArray:identifiers];
    
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
    
    self.skProductDictionary = [NSDictionary dictionaryWithObjects:skProducts forKeys:skProductIds];
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    
    //NSLog(@"Failed to load list of products: %@", error);
    _productsRequest = nil;
}

@end
