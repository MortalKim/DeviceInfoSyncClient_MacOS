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
    
    var body: some View {
//        NavigationView {
//            List {
//                //Caption
//                Text("Services")
//                //Navigation links
//                //Replace "ContentView" with your destination
//                Group{
//                    NavigationLink(destination: GenericSettings()) {
//                        Label("Lightning", systemImage: "bolt.fill")
//                    }
//                    NavigationLink(destination: Text("123")) {
//                        Text("Choose Tails")
//                    }
//                    NavigationLink(destination: Text("123")) {
//                        Text("Choose Tails")
//                    }
//                }
//                //Add some space :)
//                Spacer()
//                Text("More")
//                NavigationLink(destination: Text("123")) {
//
//                }
//                NavigationLink(destination: Text("123")) {
//
//                }
//                //Add some space again!
//                Spacer()
//                //Divider also looks great!
//                Divider()
//                NavigationLink(destination: Text("123")) {
//
//                }
//            }
//            .listStyle(SidebarListStyle())
//            .navigationTitle("Explore")
//            //Set Sidebar Width (and height)
//            .frame(minWidth: 150, idealWidth: 250, maxWidth: 800)
////            .toolbar{
////                //Toggle Sidebar Button
////                ToolbarItem(placement: .navigation){
////                    Button(action: toggleSidebar, label: {
////                        Image(systemName: "bolt.fill")
////                    })
////                }
////            }
//            .toolbar {
//                ToolbarItemGroup {
//                    Slider(
//                        value: $fontSize,
//                        in: 8...120,
//                        minimumValueLabel:
//                            Text("A").font(.system(size: 8)),
//                        maximumValueLabel:
//                            Text("A").font(.system(size: 16))
//                    ) {
//                        Text("Font Size (\(Int(fontSize)))")
//                    }
//                    .frame(width: 150)
//                    Toggle(isOn: $bold) {
//                        Image(systemName: "bold")
//                    }
//                    Toggle(isOn: $italic) {
//                        Image(systemName: "italic")
//                    }
//                }
//            }
//        }
        NavigationView{
                Text("ToolBar 演示")
                .toolbar{
                    ToolbarItem(placement:.automatic){
                        HStack(spacing:20){
                            Button(action:{print("wave")}){
                                Image(systemName: "waveform.path.badge.plus")
                                    .foregroundColor(.purple)
                                    .scaleEffect(1.5, anchor: .center)
                            }
                            
                        }
                    }
                }
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
