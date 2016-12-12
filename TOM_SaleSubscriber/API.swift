//
//  API.swift
//  TOM_SaleSubscriber
//
//  Created by Tomas Trujillo on 10/17/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import Foundation

class API {
    
    static let marketPlace = Marketplace.instantiateModel()
    
    class func unsubscribeFromMerchantWith(name: String) {
        for merc in marketPlace.merchants {
            if merc.name == name {
                merc.suscribed = false
                return
            }
        }
    }
    
    class func getMerchantWith(name: String) -> Merchant? {
        for merc in marketPlace.merchants {
            if merc.name == name {
                return merc
            }
        }
        return nil
    }
    
}
