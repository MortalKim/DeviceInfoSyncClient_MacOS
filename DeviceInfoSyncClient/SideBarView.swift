//
//  ContentView.swift
//  DeviceInfoSyncClient
//
//  Created by Kim on 8/28/22.
//

import SwiftUI

struct SideBarView: View {
    @State private var text = ""
     @State private var bold = false
     @State private var italic = false
     @State private var fontSize = 12.0
    @State var selection: Int?
    var body: some View {
        NavigationView {
            List {
                //Caption
                Text("Settings")
                //Navigation links
                //Replace "ContentView" with your destination
                Group{
                    NavigationLink(destination: GenericSettingsView(),tag: 0,selection:$selection) {
                        Label("Settings", systemImage: "gear")
                    }

                }.onAppear {
                    self.selection = 0
                }
                //Add some space :)
//                Spacer()
//                Text("More")
//                NavigationLink(destination: Text("123")) {
//
//                }
            }

            .listStyle(SidebarListStyle())
            .navigationTitle("Explore")
            //Set Sidebar Width (and height)
            .frame(minWidth: 150, idealWidth: 250, maxWidth: 800)
//            .toolbar{
//                //Toggle Sidebar Button
//                ToolbarItem(placement: .navigation){
//                    Button(action: toggleSidebar, label: {
//                        Image(systemName: "bolt.fill")
//                    })
//                }
//            }
        }

    }
}

// Toggle Sidebar Function
func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView()
    }
}
