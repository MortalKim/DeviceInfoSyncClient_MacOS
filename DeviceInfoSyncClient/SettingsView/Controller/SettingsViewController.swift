//
//  SettingsViewController.swift
//  DeviceInfoSyncClient
//
//  Created by Kim on 8/28/22.
//

import Foundation
import SwiftUI

class SettingsViewController<T:View>:NSHostingController<T>{
    override func viewWillAppear() {
        NSApp.setActivationPolicy(.regular)
    }
    
    override func viewWillDisappear() {
        NSApp.setActivationPolicy(.prohibited)
    }
}
