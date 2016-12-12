//
//  Marketplace.swift
//  TOM_SaleSubscriber
//
//  Created by Tomas Trujillo on 9/26/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import Foundation


class Marketplace {

    //MARK: Variables
    
    var merchants = [Merchant]()
    
    //MARK: Initializer
    
    static func instantiateModel() -> Marketplace {
        let marketplace = Marketplace()
        marketplace.createMockMerchants()
        return marketplace
    }
    
    func createMockMerchants() {
        let foodMerchant = Merchant()
        foodMerchant.name = "TOM Market"
        foodMerchant.description = "Buy food at the best quality and price from our shelves!"
        foodMerchant.secondsBetweenSales = 5
        foodMerchant.suscribed = false
        foodMerchant.imageName = "Market"
        let autoMerchant = Merchant()
        autoMerchant.name = "TOM Auto Shop"
        autoMerchant.description = "The best auto parts for your car. Get a free car wash for any purchase you make!"
        autoMerchant.secondsBetweenSales = 40
        autoMerchant.suscribed = false
        autoMerchant.imageName = "Auto"
        let clothesMerchant = Merchant()
        clothesMerchant.name = "TOM Clothes"
        clothesMerchant.description = "Get clothes from the most exclusive fashion designers!"
        clothesMerchant.secondsBetweenSales = 60
        clothesMerchant.suscribed = false
        clothesMerchant.imageName = "Fashion"
        let drugStoreMerchant = Merchant()
        drugStoreMerchant.name = "TOM Drugstore"
        drugStoreMerchant.description = "Every medicine that is approve by a doctor can be found in any of our stores!"
        drugStoreMerchant.secondsBetweenSales = 65
        drugStoreMerchant.suscribed = false
        drugStoreMerchant.imageName = "Pharmacy"
        let toyMerchant = Merchant()
        toyMerchant.name = "TOM Toys"
        toyMerchant.description = "Be it a birthday, Christmas or Halloween, we have the right toy for your kid!"
        toyMerchant.secondsBetweenSales = 70
        toyMerchant.suscribed = false
        toyMerchant.imageName = "Toy"
        merchants.append(foodMerchant)
        merchants.append(autoMerchant)
        merchants.append(clothesMerchant)
        merchants.append(drugStoreMerchant)
        merchants.append(toyMerchant)
    }
    
}
