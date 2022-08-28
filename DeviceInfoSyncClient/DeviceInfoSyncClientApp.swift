//
//  DeviceInfoSyncClientApp.swift
//  DeviceInfoSyncClient
//
//  Created by Kim on 8/28/22.
//

import SwiftUI
import ActivityKit
import AppKit

@main
struct DeviceInfoSyncClientApp: App {
    private var timer: Timer?
    @State var currentNumber: String = "1"
    let udpTool:UdpTool
    
    @State var window:SettingsWindowController<SideBarView>?
    
    var body: some Scene {
//        WindowGroup {
//
//              SideBarView()
//        }
        MenuBarExtra(currentNumber, systemImage: "1.circle") {
            Button("Settings") {
                showSettings()
            }
            Button("Quit") {
                exit(0)
            }
        }
    }
    
    func showSettings(){
        
        let detailView = SideBarView()
        if(window == nil){
            window = SettingsWindowController(rootView: detailView)
            window!.window?.title = "Settings"
            window!.showWindow(nil)
        }
        else{
            window!.showWindow(nil)
        }
        NSApp.activate(ignoringOtherApps: true)
    }

    
    init(){
        //init udp.
        //todo: Need change in settings
        udpTool = UdpTool(ip:"127.0.0.1",port:"8888")
        udpTool.connect()
        let observer = ActivityObserver()
        observer.updatedStatisticsHandler = {[self] observer in
            Swift.print(observer.toJSON())
            self.udpTool.sendUDP(msg:observer.statistics)
            //Swift.print(observer.statistics)
        }

        let interval = 3.0
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { _ in
            observer.update(interval: interval)
        })
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
    }
    
}
