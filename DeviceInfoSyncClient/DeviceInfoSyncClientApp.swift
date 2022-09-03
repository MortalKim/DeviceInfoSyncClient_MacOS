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
    let observer = ActivityObserver()
    private var timer: Timer?
    @State var currentNumber: String = "1"
    var udpTool:UdpTool?
    
    @State var window:SettingsWindowController<SideBarView>?
    public var ToUDP = UserDefaults.standard.bool(forKey: Constant.TO_UDP){
        willSet{
            print("New value is \(newValue) and old is \(ToUDP)")
            UserDefaults.standard.set(newValue, forKey: Constant.TO_UDP)
            UserDefaults.standard.synchronize()

        }
        didSet(oldValue){
            Swift.print("new udp value: \(oldValue) to " + String(ToUDP))
            initUdp()
            activityObserver()
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
        activityObserver()
        DeviceInfoSyncClientApp.instance = self
    }
    
    public mutating func activityObserver(){
        observer.stop()
        observer.updatedStatisticsHandler = nil
        observer.updatedStatisticsHandler = {[self] observer in
            //todo: update info on UI
            var jsonData = observer.toJSON()!
            Swift.print(jsonData)
            if(ToUDP){
                self.udpTool?.sendUDP(msg:jsonData)
            }
        }
        observer.start(interval: 3)
    }
    
    public mutating func initUdp(){
        if(ToUDP){
            //init udp.
            //todo: Need change in settings
            udpTool?.close()
            var ip: String = UserDefaults.standard.string(forKey: Constant.REMOTE_IP) ?? ""
            var port: Int = UserDefaults.standard.integer(forKey: Constant.REMOTE_PORT)
            udpTool = UdpTool(ip:ip,port:String(port))
            udpTool?.connect()
            Swift.print("Start connection")
        }
        else{
            Swift.print("Close connection")
            udpTool?.close()
        }
    }
    
}
