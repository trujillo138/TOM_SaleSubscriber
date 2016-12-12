//
//  MerchantTableViewCell.swift
//  TOM_SaleSubscriber
//
//  Created by Tomas Trujillo on 9/27/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

class MerchantTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    
    @IBOutlet private weak var merchantImageView: UIImageView!
    
    @IBOutlet private weak var merchantNameLabel: UILabel!
    
    //MARK: Variables
    
    var imageName: String? {
        didSet {
            guard let name = imageName else {
                return
            }
            merchantImageView.image = UIImage(named: name)
        }
    }
    
    var merchantName: String? {
        didSet {
            merchantNameLabel.text = merchantName
        }
    }

}
