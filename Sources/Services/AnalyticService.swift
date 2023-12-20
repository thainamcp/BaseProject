//
//  AnalyticService.swift
//  AnalyticService
//
//  Created by Nam MacMini on 10/08/2021.
//  Copyright © 2021 Vulcan Labs. All rights reserved.
//

import Foundation
import FirebaseAnalytics

enum Event: String {
    case demo
}

final class AnalyticService {
    static func logEvent(_ event: Event, value: String) {
        Analytics.logEvent(event.rawValue, parameters: [
            AnalyticsParameterItemID: value
        ])
    }
}
