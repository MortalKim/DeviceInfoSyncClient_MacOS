//
//  GenericSettingsViewModel.swift
//  DeviceInfoSyncClient
//
//  Created by Kim on 8/29/22.
//

import Foundation

class GenericSettingsViewModel:ObservableObject{
    @Published public var username: String = ""
    public func testConnection(){
        Swift.print("Click!")
    }
}
