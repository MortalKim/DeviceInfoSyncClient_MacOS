//
//  GenericSettingsViewModel.swift
//  DeviceInfoSyncClient
//
//  Created by Kim on 8/29/22.
//

import Foundation
import SwiftUI

class GenericSettingsViewModel:ObservableObject{
    @Published public var ip: String = UserDefaults.standard.string(forKey: Constant.REMOTE_IP) ?? ""
    @Published public var port: Int = UserDefaults.standard.integer(forKey: Constant.REMOTE_PORT)    //alert
    @Published public var alertShow = false
    @Published public var alertTitle: String = ""
    @Published public var alertMsg: String = ""
    @Published public var alertButtonText: String = ""
    
    @Published var checked: Bool = UserDefaults.standard.bool(forKey: Constant.TO_UDP)
    
    private var udpTool:UdpTool?
    
    //Test ip and port
    public func testConnection(){
        Swift.print(ip + " asds " + String(port))
        if(UdpTool.validateIpAddress(ipToValidate: ip)){
            //todo show testing wait dialog
            showAlert(newAlertTitle: "Testing", newAlertMsg: "Please wait..", buttonText: "Cancel")
            udpTool = UdpTool(ip: ip, port: String(port),selfPort:  "1234")
            udpTool?.connect()
            var haveResponse = false;
            udpTool?.receive {[self] (data, context, isComplete, error) in
                if(data == nil) {
                    return
                }
                haveResponse = true
                var res = String(decoding: data!, as: UTF8.self)
                if(res == "Yes"){
                    dismissAlert()
                    showAlert(newAlertTitle: "Success", newAlertMsg: "Target is available", buttonText: "OK")
                }
                else{
                    dismissAlert()
                    showAlert(newAlertTitle: "Wrong Target", newAlertMsg: "Target return wrong data.", buttonText: "OK")
                }
            }
            udpTool?.sendUDP(msg: "Is any one here?")
            
            //wait for 5 second
            DispatchQueue.global(qos: .userInitiated).async() {
                Thread.sleep(forTimeInterval: 5)
                //if not response and wait dialog is showing,
                if(!haveResponse && self.alertShow){
                    self.dismissAlert()
                    self.showAlert(newAlertTitle: "Timeout", newAlertMsg: "Target is timeout.", buttonText: "OK")
                }
            }
        }
        else{
            showAlert(newAlertTitle: "IP Error", newAlertMsg: "Not a real Ip",buttonText: "OK")
        }
    }
    
    public func confirmIpConfig(){
        if(UdpTool.validateIpAddress(ipToValidate: ip)){
            UserDefaults.standard.set(ip, forKey: Constant.REMOTE_IP)
            UserDefaults.standard.set(port, forKey: Constant.REMOTE_PORT)
        }
        else{
            showAlert(newAlertTitle: "IP Error", newAlertMsg: "Not a real Ip",buttonText: "OK")
        }
        
    }
    
    public func toggleTransmission(){
        checked.toggle()
        Swift.print("Tansmission will set to \(checked)")
        DeviceInfoSyncClientApp.instance!.ToUDP = checked
        Swift.print("ToUDP set to \(DeviceInfoSyncClientApp.instance!.ToUDP)")
    }

    func showAlert(newAlertTitle:String, newAlertMsg:String, buttonText:String) {
        DispatchQueue.main.async() {
            self.alertTitle = newAlertTitle
            self.alertMsg = newAlertMsg
            self.alertButtonText = buttonText
            self.alertShow = true;
        }
    }
    
    func dismissAlert(){
        if(Thread.isMainThread){
            self.alertShow = false
        }
        else{
            DispatchQueue.main.sync {
                self.alertShow = false
            }
        }
    }
    
    func alertButtonClick(){
        udpTool?.close()
        dismissAlert()
    }
}
