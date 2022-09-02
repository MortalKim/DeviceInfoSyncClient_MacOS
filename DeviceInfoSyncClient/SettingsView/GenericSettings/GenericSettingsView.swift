//
//  GenericSettings.swift
//  DeviceInfoSyncClient
//
//  Created by Kim on 8/28/22.
//

import SwiftUI

struct GenericSettingsView: View {
    @ObservedObject var viewModel:GenericSettingsViewModel// = GenericSettingsViewModel()
    @State var details: AlertDetails?
    
    var body: some View {
        VStack {
            HStack {
                Text("Ip")
                TextField(
                    "Ip",
                    text: $viewModel.ip
                )
                .frame(width: 100)
                Stepper(value: $viewModel.port, in: 0...65535) {
                            EmptyView()
                }
            }
            .padding(10)
            .frame(height: 50)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            
            HStack {
                    Text("Port")
                    TextField("", value: $viewModel.port, formatter: NumberFormatter())
                        .frame(width: 100)
                    Stepper(value: $viewModel.port, in: 0...65535) {
                                EmptyView()
                    }
            }
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
        .alert(
            self.viewModel.alertTitle, isPresented: self.$viewModel.alertShow, presenting: viewModel.alertMsg
        ) { detail in
            //body
            Button(self.viewModel.alertButtonText) {
                // handle retry action.
                viewModel.alertButtonClick()
            }
        } message: { detail in
            Text(detail)
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



struct AlertDetails {
    let error: String
}
