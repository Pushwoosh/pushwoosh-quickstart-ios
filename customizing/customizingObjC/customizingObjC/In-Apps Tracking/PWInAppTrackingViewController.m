//
//  PWInAppTrackingViewController.m
//  customizingObjC
//
//  Created by Pushwoosh
//
/*
 ******************************************************
 * CHANGE <Pushwoosh_APPID>                           *
 * VALUE IN THE INFO.PLIST FILE.                      *
 * REPLACE XXXXX-XXXXX WITH YOUR APP ID PROJECT CODE. *
 ******************************************************
 */

#import "PWInAppTrackingViewController.h"

#import <StoreKit/StoreKit.h>
#import <Pushwoosh/Pushwoosh.h>

@interface PWInAppTrackingViewController () <SKProductsRequestDelegate, SKPaymentTransactionObserver, SKRequestDelegate>

@property (nonatomic, strong) SKProductsRequest *request;
@property (nonatomic, strong) NSArray<SKProduct *> *products;

@end

@implementation PWInAppTrackingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self canMakePayments]) {
        [self validateProductIdentifiers:@[@"inapp_demo_purchase_name"]];
    }
}

- (BOOL)canMakePayments {
    return [SKPaymentQueue canMakePayments];
}

- (void)validateProductIdentifiers:(NSArray *)productIdentifiers {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc]
                                          initWithProductIdentifiers:[NSSet setWithArray:productIdentifiers]];
    
    
    self.request = productsRequest;
    productsRequest.delegate = self;
    [productsRequest start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    self.products = response.products;
        
    for (NSString *invalidIdentifier in response.invalidProductIdentifiers)
        NSLog(@"Invalid identefier : %@", invalidIdentifier);
    
}

- (void)payWithIdentefier:(NSString*)identifier {
    for (SKProduct *product in self.products) {
        if ([product.productIdentifier isEqualToString:identifier]) {
            SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
    }
}

- (void)refreshReceipt {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    
    // In-Apps Tracking Pushwoosh code here
    [[Pushwoosh sharedInstance] sendSKPaymentTransactions:transactions];
    // the rest of the code, consume transactions, etc
    
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"Pushwoosh - SKPaymentTransactionStatePurchased:  %@",transaction.payment.productIdentifier);
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"Pushwoosh - SKPaymentTransactionStateFailed: %@",transaction.error.description);
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Pushwoosh - SKPaymentTransactionStateRestored: %@",transaction.payment.productIdentifier);
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction inQueue:(SKPaymentQueue *)queue {
    NSLog(@"Pushwoosh: - Transaction Failed with error: %@", transaction.error);
    [queue finishTransaction:transaction];
}

- (void)deferredTransaction:(SKPaymentTransaction *)transaction inQueue:(SKPaymentQueue *)queue {
    NSLog(@"Pushwoosh: - Transaction Deferred: %@", transaction);
}

- (IBAction)closeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
