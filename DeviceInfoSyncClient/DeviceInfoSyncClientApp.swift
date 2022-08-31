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
    public static var instance :DeviceInfoSyncClientApp?
    
    private var timer: Timer?
    @State var currentNumber: String = "1"
    @State var udpTool:UdpTool?
    
    @State var window:SettingsWindowController<SideBarView>?
    @State public var ToUDP = UserDefaults.standard.bool(forKey: Constant.TO_UDP){
        didSet{
            initUdp()
        }
    }
    
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
        initUdp()
        let observer = ActivityObserver()
        observer.updatedStatisticsHandler = {[self] observer in
            //todo: update info on UI
            Swift.print(observer.toJSON())
            if(ToUDP){
                self.udpTool?.sendUDP(msg:observer.statistics)
            }
        }

        let interval = 3.0
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { _ in
            observer.update(interval: interval)
        })
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        
        DeviceInfoSyncClientApp.instance = self
    }
    
    public func initUdp(){
        if(ToUDP){
            //init udp.
            //todo: Need change in settings
            udpTool = UdpTool(ip:"127.0.0.1",port:"8888")
            udpTool?.connect()
        }
        else{
            udpTool?.close()
        }
    }
    
}
