//
//  DeviceInfoSyncClientApp.swift
//  DeviceInfoSyncClient
//
//  Created by Kim on 8/28/22.
//

import SwiftUI
import ActivityKit

@main
struct DeviceInfoSyncClientApp: App {
    private var timer: Timer?

    @State var currentNumber: String = "1"
    let udpTool:UdpTool
    
    var body: some Scene {
        WindowGroup {
            ContentView()

        }
        MenuBarExtra(currentNumber, systemImage: "\(currentNumber).circle") {
            Button("Settings") {
                currentNumber = "1"
            }
            Button("Quit") {
                currentNumber = "2"
            }
        }
    }
    
    
    
    init(){
        udpTool = UdpTool(ip:"127.0.0.1",port:"8888")
        udpTool.connect()
        let observer = ActivityObserver()
        observer.updatedStatisticsHandler = {[self] observer in
            Swift.print(observer.statistics)
            self.udpTool.sendUDP(msg:observer.statistics)
        }

        let interval = 3.0
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { _ in
            observer.update(interval: interval)
        })
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
    }
}
