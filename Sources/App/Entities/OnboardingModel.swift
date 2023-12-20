import Foundation
import UIKit

struct OnboardingModel {
    let background: String
    let title: String
    let button: String
}

let listOnboarding: [OnboardingModel] = [
    OnboardingModel(background: "ob_1", title: "Always on display\nPerfect", button: "icon_next_ob"),
    OnboardingModel(background: "ob_2", title: "Explore a world\nof Clock", button: "icon_next_ob"),
    OnboardingModel(background: "ob_3", title: "Many animated widgets\nfor your phone", button: "icon_explore_ob")
]
