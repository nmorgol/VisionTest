

import Foundation
import StoreKit


class IAPManager: NSObject {
    
    static let shared = IAPManager()
    static let productNotificationIdentifier = "IAPManagerProductIdentifier"
    
    var products: [SKProduct] = []
    let paymentQueue = SKPaymentQueue.default()
    
    private override init() {
        
    }
    
    
    
    public func setupPurchases(callBack: @escaping(Bool) -> ()){
        if SKPaymentQueue.canMakePayments(){
            SKPaymentQueue.default().add(self)
            callBack(true)
            return
        }
        callBack(false)
    }
    
    public func getProducts(){
        
        let identifiers: Set = [
            IAPProducts.moreThanOneUser.rawValue,
            IAPProducts.speechRecognition.rawValue,
            IAPProducts.automaticDistanceDetection.rawValue
        ]
        
        let productRequest = SKProductsRequest(productIdentifiers: identifiers)
        
        productRequest.delegate = self
        productRequest.start()
        
    }
    
    public func purchase(productWith identifier: String){
        guard let product = products.filter({$0.productIdentifier == identifier}).first else {return}
        let payment = SKPayment(product: product)
        paymentQueue.add(payment)
    }
    
    public func restoreComplitedTransactions(){
        paymentQueue.restoreCompletedTransactions()
    }
    
}


extension IAPManager: SKPaymentTransactionObserver{
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions{
            switch transaction.transactionState {
            case .deferred:
                break
            case .purchasing:
                break
            case .failed:
                failed(transaction: transaction)
            case .purchased:
                complited(transaction: transaction)
            case .restored:
                restored(transaction: transaction)
            default:
                return
            }
        }
    }
    
    private func failed(transaction: SKPaymentTransaction){
        if let transactionError = transaction.error as NSError?{
            if transactionError.code != SKError.paymentCancelled.rawValue{
                print("ошибка танзакции:  \(transaction.error!.localizedDescription)")
            }
        }
        paymentQueue.finishTransaction(transaction)
    }
    
    private func complited(transaction: SKPaymentTransaction){
        NotificationCenter.default.post(name: NSNotification.Name(transaction.payment.productIdentifier), object: nil)
        paymentQueue.finishTransaction(transaction)
    }
    
    private func restored(transaction: SKPaymentTransaction){
        NotificationCenter.default.post(name: NSNotification.Name(transaction.payment.productIdentifier), object: nil)
        paymentQueue.finishTransaction(transaction)
    }
}

extension IAPManager: SKProductsRequestDelegate{
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        products.forEach{print($0.localizedTitle)}
        
        if products.count > 0{
            NotificationCenter.default.post(name: NSNotification.Name(IAPManager.productNotificationIdentifier), object: nil)
        }
    }
    
}
