//
//  MarketplaceViewController.swift
//  TOM_SaleSubscriber
//
//  Created by Tomas Trujillo on 9/27/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit
import UserNotifications

class MarketplaceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: Variables
    
    private lazy var marketplace = API.marketPlace
    
    //MARK: Constants
    
    private struct MarketplaceVCConstants {
        static let merchantTableViewCellIdentifier = "MerchantCell"
        static let GoToSaleDetailSegueIdentifier = "ShowMerchantDetail"
    }
    
    //MARK: Viewcontroller Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        marketplace.createMockMerchants()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "MerchantTableViewCell", bundle: nil) ,
                           forCellReuseIdentifier: MarketplaceVCConstants.merchantTableViewCellIdentifier)
        requestNotificationAuthorization()
    }
    
    private func requestNotificationAuthorization() {
        let uNNotificationCenter = UNUserNotificationCenter.current()
        uNNotificationCenter.requestAuthorization(options: [.sound, .alert]) { (grantAccess, error) in
            //Do something if denied permission
        }
    }
    
    //MARK: UITableView Delegate and Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marketplace.merchants.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MarketplaceVCConstants.merchantTableViewCellIdentifier) as? MerchantTableViewCell else {
            return UITableViewCell()
        }
        let merchant = marketplace.merchants[indexPath.row]
        cell.imageName = merchant.imageName
        cell.merchantName = merchant.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: MarketplaceVCConstants.GoToSaleDetailSegueIdentifier, sender: tableView.cellForRow(at: indexPath))
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {
            return
        }
        if segueIdentifier == MarketplaceVCConstants.GoToSaleDetailSegueIdentifier {
            guard let cell = sender as? UITableViewCell,
             let indexPath = tableView.indexPath(for: cell),
                let merchantViewController = segue.destination as? MerchantViewController else {
                return
            }
            let merchant = marketplace.merchants[indexPath.row]
            merchantViewController.merchant = merchant
        }
    }


}
