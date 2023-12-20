//
//  Schedulers.swift
//  AODApp
//
//  Created by Nam Nguyen on 7/18/20.
//  Copyright © 2020 Vulcan Labs. All rights reserved.
//

import Foundation
import RxSwift

struct Schedulers {
    let main = MainScheduler.instance
    let background = SerialDispatchQueueScheduler.init(qos: .background)
    let utility = SerialDispatchQueueScheduler.init(qos: .utility)
    let userInitiated = SerialDispatchQueueScheduler.init(qos: .userInteractive)
}

let scheduler = Schedulers()
