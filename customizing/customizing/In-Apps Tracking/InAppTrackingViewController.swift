//
//  InAppTrackingViewController.swift
//  customizing
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

import UIKit
import StoreKit

import Pushwoosh

class InAppTrackingViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    var productIDs: [String] = []
    
    var productsArray: [SKProduct] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        productIDs.append("inapp_demo_purchase_name")
        
        requestProductInfo()

        SKPaymentQueue.default().add(self)
    }
    
    func requestProductInfo() {
        if SKPaymentQueue.canMakePayments() {
            let productIdentifiers = NSSet(array: productIDs)
            let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
            
            productRequest.delegate = self
            productRequest.start()
        }
        else {
            print("Cannot perform In App Purchases.")
        }
    }
    
    func startPurchasing() {
        let payment = SKPayment(product: self.productsArray[0] as SKProduct)
        SKPaymentQueue.default().add(payment)
    }
    
    // MARK: -
    // MARK: - SKProductsRequestDelegate
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count != 0 {
            for product in response.products {
                productsArray.append(product)
            }
        } else {
            print("There are no products.")
        }
        
        if response.invalidProductIdentifiers.count != 0 {
            print(response.invalidProductIdentifiers.description)
        }
    }
    
    // MARK: -
    // MARK: - SKPaymentTransactionObserver
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        // In-Apps Tracking Pushwoosh code here
        Pushwoosh.sharedInstance().sendSKPaymentTransactions(transactions)
        // the rest of the code, consume transactions, etc
        
        for transaction in transactions {
            switch transaction.transactionState {
            case SKPaymentTransactionState.purchased:
                print("Transaction completed successfully.")
                SKPaymentQueue.default().finishTransaction(transaction)
                
            case SKPaymentTransactionState.failed:
                print("Transaction Failed");
                SKPaymentQueue.default().finishTransaction(transaction)
                
            default:
                print(transaction.transactionState.rawValue)
            }
        }
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

/*
 In paymentQueue:updatedTransactions: delegate method call sendSKPaymentTransactions method of PushManager
 
 func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
     Pushwoosh.sharedInstance().sendSKPaymentTransactions(transactions)
 }
 (swift)
 
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
   [[PushNotificationManager pushManager] sendSKPaymentTransactions:transactions];
   //the rest of the code, consume transactions, etc
 }
 (Objective-C)
 
 */
