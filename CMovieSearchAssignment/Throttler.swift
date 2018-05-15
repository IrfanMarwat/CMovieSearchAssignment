//
//  Throttler.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/15/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

/*
    This class will make sure to perform a job only once in a given time. If a user is typing in searchbar, this class will avoid accessive network calls and result in better UI. Instantiate this class by giving delay in seconds.
 */

import UIKit
import Foundation

public class Throttler {
    
    private let queue: DispatchQueue = DispatchQueue.global(qos: .background)
    private var job: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun: Date = Date.distantPast
    private var maxInterval: Double
    
    init(seconds: Double) {
        maxInterval = seconds
    }
    
    
    func throttle(block: @escaping () -> ()) {
        job.cancel()
        job = DispatchWorkItem(){ [weak self] in
            self?.previousRun = Date()
            block()
        }
        queue.asyncAfter(deadline: .now() + maxInterval, execute: job)
    }
}

private extension Date {
    static func second(from referenceDate: Date) -> Int {
        return Int(Date().timeIntervalSince(referenceDate).rounded())
    }
}

