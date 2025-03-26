//
//  Debouncer.swift
//  Weather
//
//  Created by Дарина Самохина on 25.03.2025.
//

import Foundation

class Debouncer {
    
    private let delay: TimeInterval
    private let queue: DispatchQueue
    private var workItem: DispatchWorkItem?
    
    init(delay: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
        self.delay = delay
        self.queue = queue
    }
    
    func debounce(action: @escaping (() -> Void)) {
        workItem?.cancel()
        workItem = DispatchWorkItem { [weak self] in
            action()
            self?.workItem = nil
        }
        if let workItem = workItem {
            queue.asyncAfter(deadline: .now() + delay, execute: workItem)
        }
    }
}
