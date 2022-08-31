//
//  UdpTool.swift
//  DeviceInfoSyncClient
//
//  Created by Kim on 8/28/22.
//

import Foundation
import Network

class UdpTool{
    let ip:NWEndpoint.Host
    let port:NWEndpoint.Port
    var connection:NWConnection
    init(ip:String, port:String) {
        self.ip = NWEndpoint.Host(ip)
        self.port = NWEndpoint.Port(port)!
        connection=NWConnection(host: self.ip, port: self.port, using: .udp)
    }
    
    public func connect(){
        connection.stateUpdateHandler = { (newState) in
            print("This is stateUpdateHandler:")
            switch (newState) {
                case .ready:
                    print("State: Ready\n")
                case .setup:
                    print("State: Setup\n")
                case .cancelled:
                    print("State: Cancelled\n")
                case .preparing:
                    print("State: Preparing\n")
                default:
                    print("ERROR! State not defined!\n")
            }
        }
            
        connection.start(queue: .global())
    }
    
    public func sendUDP(msg:String){
        let contentToSend=msg.data(using: String.Encoding.utf8)
            connection.send(content: contentToSend, completion: NWConnection.SendCompletion.contentProcessed({(NWError) in
                if NWError==nil{
                    print("Data was sent to UDP")
                }else{
                    print("ERROR! Error when data (Type: Data) sending. NWError: \n \(NWError!)")
                }
            }))
    }
    
    public func close(){
        connection.cancel()
    }
}
