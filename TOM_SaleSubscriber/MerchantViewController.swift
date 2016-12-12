//
//  MerchantViewController.swift
//  TOM_SaleSubscriber
//
//  Created by Tomas Trujillo on 10/5/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit
import UserNotifications

class MerchantViewController: UIViewController, T_TimerDelegate, CountdownViewDelegate {

    //MARK: Outlets
    
    @IBOutlet private weak var merchantImageView: UIImageView!
    
    @IBOutlet private weak var merchantDescriptionTextView: UITextView!
    
    @IBOutlet private weak var subscriptionButton: UIButton!
    
    @IBOutlet private weak var countdownView: CountdownView!
    
    
    //MARK: Variables
    
    var merchant: Merchant?
    
    var saleTimer: T_Timer?
    
    //MARK: Constants
    
    private struct MerchantVCConstants {
        static let SubscribeButtonTitle = "Subscribe to RSS"
        static let UnsubscribeButtonTitle = "Unsubscribe from RSS"
    }
    
    //MARK: Viewcontroller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startTimerIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saleTimer?.stopTimer()
    }
    
    private func setup() {
        guard let merc = merchant else {
            return
        }
        merchantImageView.image = UIImage(named: merc.imageName ?? "")
        merchantDescriptionTextView.text = merc.description
        title = merc.name
        updateSubscriptionButtonTitle()
        countdownView.delegate = self
    }
    
    //MARK: Timer
    
    private func startTimerIfNeeded() {
        guard let merc = merchant else {
            return
        }
        if merc.suscribed {
            startTimerToMerchantNextSaleDate()
        }
    }
    
    private func startTimerToMerchantNextSaleDate() {
        guard let nextSaleDate = merchant?.nextSaleDate else {
            return
        }
        if merchant?.sold ?? false {
            countdownView.expired = true
        } else {
            let seconds = nextSaleDate.timeIntervalSince(Date())
            saleTimer = T_Timer.fireTimerWith(seconds: seconds)
            saleTimer?.delegate = self
            countdownView.active = true
            countdownView.finished = false
        }
    }
    
    private func setLocalNotification() {
        guard let nextSaleDate = merchant?.nextSaleDate else {
            return
        }
        let uNNotificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Available sale!"
        content.body = "Enter to purchase or cancel your suscription"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = APINotification.SaleActionsCategoryIdentifier
        content.badge = 1
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: nextSaleDate.timeIntervalSince(Date()), repeats: false)
        let request = UNNotificationRequest(identifier: merchant?.name ?? "", content: content, trigger: trigger) // Schedule the notification.
        uNNotificationCenter.add(request)
    }
    
    private func removePendingForMerchant() {
        let uNNotificationCenter = UNUserNotificationCenter.current()
        uNNotificationCenter.removePendingNotificationRequests(withIdentifiers: [merchant?.name ?? ""])
    }
    
    //MARK: Timer delegate
    
    func timerUpdated(seconds: Double, timer: T_Timer) {
        countdownView.seconds = Int(round(seconds))
    }
    
    func timerFinished(timer: T_Timer) {
        countdownView.finished = true
    }
    
    //MARK: Countdown View delegate
    
    func pressedSaleButton() {
        let alertController = UIAlertController(title: "Sale purchased!", message: "Thanks for your purchase. Expect delivery in the next 24 hours",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            self.merchant?.sold = true
            self.updateSubscriptionButtonTitle()
        })
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Actions
    
    @IBAction private func subscribeButtonPressed(_ sender: AnyObject) {
        guard let merc = merchant else {
            return
        }
        merc.suscribed = !merc.suscribed
        if !merc.suscribed {
            saleTimer?.stopTimer()
            countdownView.active = false
            removePendingForMerchant()
        } else {
            startTimerToMerchantNextSaleDate()
            setLocalNotification()
        }
        updateSubscriptionButtonTitle()
    }
    
    private func updateSubscriptionButtonTitle() {
        guard let merc = merchant else {
            return
        }
        if merc.sold {
            subscriptionButton.isEnabled = false
        } else {
            subscriptionButton.setTitle(merc.suscribed ? MerchantVCConstants.UnsubscribeButtonTitle : MerchantVCConstants.SubscribeButtonTitle, for: .normal)
        }
    }

}
