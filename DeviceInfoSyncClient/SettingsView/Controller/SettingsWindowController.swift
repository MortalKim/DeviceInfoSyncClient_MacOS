//
//  SettingsWindowController.swift
//  DeviceInfoSyncClient
//
//  Created by Kim on 8/28/22.
//

import Foundation
import AppKit
import SwiftUI

class SettingsWindowController<RootView : View>: NSWindowController,NSToolbarDelegate {
    convenience init(rootView: RootView) {
        //set window size
        let hostingController = SettingsViewController(rootView: rootView.frame(width: 800, height: 600))
        let window = NSWindow(contentViewController: hostingController)
        window.setContentSize(NSSize(width: 800, height: 600))

        //add a toolbar
        let toolbar = NSHostingView(rootView: Button(action: toggleSidebar, label: {
            Image(systemName: "sidebar.left")
        }))
        toolbar.frame.size = toolbar.fittingSize
        let toolbarController = NSTitlebarAccessoryViewController()
        toolbarController.view = toolbar
        window.addTitlebarAccessoryViewController(toolbarController)
        
        self.init(window: window)
    }
}
