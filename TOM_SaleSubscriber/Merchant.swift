//
//  Merchant.swift
//  TOM_SaleSubscriber
//
//  Created by Tomas Trujillo on 9/26/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import Foundation

class Merchant {
    
    //MARK: Variables
    
    var name: String?
    
    var description: String?
    
    var secondsBetweenSales: Double = 0.0
    
    var suscribed = false {
        didSet {
            if suscribed {
                self.updateNextSaleDate()
            }
        }
    }
    
    var sold = false
    
    var imageName: String?
    
    var nextSaleDate: Date?
    
    private func updateNextSaleDate() {
        nextSaleDate = Date().addingTimeInterval(secondsBetweenSales)
    }
    
}
