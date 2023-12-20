//
//  ServerConfigModel.swift
//  TimelessTalkApp
//
//  Created by thainam on 17/03/2023.
//  Copyright © 2023 Vulcan Labs. All rights reserved.
//

import Foundation
import UIKit

struct ServerConfigModel: Codable {
    let model: String
    let limit_text: Int
    let max_tokens: Int
    let follow_up: Int
}
