//
//  CountdownView.swift
//  TOM_SaleSubscriber
//
//  Created by Tomas Trujillo on 10/5/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import UIKit

protocol CountdownViewDelegate {
    func pressedSaleButton()
}

class CountdownView: UIView {

    //MARK: Variables
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(tapView))
    }()
    
    var delegate: CountdownViewDelegate?
    
    var seconds: Int = 0 {
        didSet {
            let secondsRem = seconds % 60
            let minutes = (seconds - secondsRem) / 60
            let formatseconds = secondsRem < 10 ? "0\(secondsRem)" : "\(secondsRem)"
            let formatMinutes = minutes < 10 ? "0\(minutes)" : "\(minutes)"
            timerLabel?.text = "\(formatMinutes):\(formatseconds)"
        }
    }
    
    var active = false {
        didSet {
            UIView.transition(with: self, duration: 1.0, options: .transitionCrossDissolve, animations: {
                self.setAlphaAccordingToActive()
                }, completion: nil)
        }
    }
    
    var finished = false {
        didSet {
            UIView.transition(with: self, duration: 1.0, options: .transitionCrossDissolve, animations: {
                self.setBackgroundColorAccordingToFinish()
                }, completion: nil)
        }
    }
    
    var expired = false {
        didSet {
            UIView.transition(with: self, duration: 1.0, options: .transitionCrossDissolve, animations: {
                self.setBackgroundColorAccordingToFinish()
                self.setAlphaAccordingToActive()
                }, completion: nil)
        }
    }
    
    private var timerLabel: UILabel?
    
    //MARK: Timer
    
    private func setAlphaAccordingToActive() {
        if expired {
            alpha = 1.0
        } else {
            if active {
                alpha = 1.0
            } else {
                alpha = 0.0
            }
        }
    }
    
    private func setBackgroundColorAccordingToFinish() {
        if expired {
            backgroundColor = UIColor.lightGray
            timerLabel?.text = "SOLD"
            tapGesture.isEnabled = false
        } else {
            if finished {
                backgroundColor = UIColor.red
                timerLabel?.text = "SALE!"
                tapGesture.isEnabled = true
            } else {
                backgroundColor = UIColor.black
                tapGesture.isEnabled = false
            }
        }
    }
    
    //MARK: Initializer
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if timerLabel == nil {
            timerLabel = UILabel(frame: bounds)
            timerLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
            timerLabel?.textColor = UIColor.white
            timerLabel?.textAlignment = .center
            addSubview(timerLabel!)
        } else {
            timerLabel?.frame = bounds
        }
        setBackgroundColorAccordingToFinish()
        setAlphaAccordingToActive()
    }
    
    private func setup() {
        isOpaque = false
        setBackgroundColorAccordingToFinish()
        setAlphaAccordingToActive()
        addGestureRecognizer(tapGesture)
        tapGesture.isEnabled = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    //MARK: Gesture
    
    func tapView(tapGesture: UITapGestureRecognizer) {
        delegate?.pressedSaleButton()
        expired = true
    }
    
    
}
