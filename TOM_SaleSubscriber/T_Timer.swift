//
//  T_Timer.swift
//  TOM_SaleSubscriber
//
//  Created by Tomas Trujillo on 10/9/16.
//  Copyright © 2016 TOMApps. All rights reserved.
//

import Foundation

protocol T_TimerDelegate {
    func timerUpdated(seconds: Double, timer: T_Timer)
    func timerFinished(timer: T_Timer)
}

class T_Timer {
    
    //MARK: Variables
    
    private var seconds = 0.0
    
    private var timer: Timer?
    
    var delegate: T_TimerDelegate?
    
    //MARK: Timer Methods
    
    public class func fireTimerWith(seconds: Double) -> T_Timer {
        let timer = T_Timer()
        timer.startTimerWith(seconds: seconds)
        return timer
    }
    
    private func startTimerWith(seconds: Double) {
        self.seconds = seconds
        let runLoop = RunLoop.current
        timer = Timer(fire: Date(), interval: 1, repeats: true) { [weak self] tim in
            guard let welf = self else {
                return
            }
            welf.seconds = welf.seconds - 1
            if (welf.seconds <= 0) {
                tim.invalidate()
                welf.delegate?.timerFinished(timer: welf)
            } else {
                welf.delegate?.timerUpdated(seconds: welf.seconds, timer: welf)
            }
        }
        runLoop.add(self.timer!, forMode: .defaultRunLoopMode)
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        self.delegate?.timerFinished(timer: self)
    }
    
    //MARK: Timer delegate
}
