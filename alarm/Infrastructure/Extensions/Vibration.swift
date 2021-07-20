//
//  Vibration.swift
//  alarm
//
//  Created by Ilia Tsikelashvili on 19.07.21.
//

import UIKit
import AVFoundation

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
