//
//  GenericSettings.swift
//  DeviceInfoSyncClient
//
//  Created by Kim on 8/28/22.
//

import SwiftUI

struct GenericSettingsView: View {
    @ObservedObject var viewModel:GenericSettingsViewModel// = GenericSettingsViewModel()
    var body: some View {
        VStack {
            
            TextField(
                "Ip",
                text: $viewModel.username
            )
            .padding(10)
            .frame(height: 50)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            TextField(
                "Port",
                text: $viewModel.username
            )
            .padding(10)
            .frame(height: 50)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            Text("Input your show info device ip and port").padding()
            
            HStack{
                Button(action: viewModel.testConnection) {
                    Text("Test Connection")
                }
                
                Button(action: viewModel.testConnection) {
                    Text("Confirm")
                }
            }
        }
        
        
    }
    init() {
        self.viewModel = GenericSettingsViewModel()
    }
}


struct GenericSettings_Previews: PreviewProvider {
    static var previews: some View {
        GenericSettingsView()
    }
}
