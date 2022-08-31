//
//  GenericSettingsViewModel.swift
//  DeviceInfoSyncClient
//
//  Created by Kim on 8/29/22.
//

import Foundation
import SwiftUI

class GenericSettingsViewModel:ObservableObject{
    @Published public var ip: String = ""
    @Published public var port: Int = 0
    
    //alert
    @Published public var alertDetails: AlertDetails?
    @Published public var alertShow = false
    @Published public var alertTitle: String = ""
    @Published public var alertMsg: String = ""
    
    private var udpTool:UdpTool?
    
    //Test ip and port
    public func testConnection(){
        Swift.print(ip + " asds " + String(port))
        if(UdpTool.validateIpAddress(ipToValidate: ip)){
            //todo show testing wait dialog
            
            udpTool = UdpTool(ip: ip, port: String(port))
        }
        else{
            showAlert(newAlertTitle: "IP Error", newAlertMsg: "Not a real Ip")
        }
    }

    func showAlert(newAlertTitle:String, newAlertMsg:String) {
        alertTitle = newAlertTitle
        alertMsg = newAlertMsg
        alertShow = true;
    }
}
