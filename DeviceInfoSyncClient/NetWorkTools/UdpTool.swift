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
    let selfPort:NWEndpoint.Port
    var connection:NWConnection
    init(ip:String, port:String) {
        self.ip = NWEndpoint.Host(ip)
        self.port = NWEndpoint.Port(port)!
        connection=NWConnection(host: self.ip, port: self.port, using: .udp)
        self.selfPort = 0
    }
    
    init(ip:String, port:String, selfPort:String) {
        self.ip = NWEndpoint.Host(ip)
        self.port = NWEndpoint.Port(port)!
        self.selfPort = NWEndpoint.Port(selfPort)!
        
        let params = NWParameters(dtls: nil, udp: .init())
        params.requiredLocalEndpoint = NWEndpoint.hostPort(host: .ipv4(.any), port: self.selfPort)

        connection=NWConnection(host: self.ip, port: self.port, using: params)
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
    
    public func receive(completion: @escaping (_ completeContent: Data?, _ contentContext: NWConnection.ContentContext?, _ isComplete: Bool, _ error: NWError?) -> Void){
        connection.receiveMessage(completion: completion)
    }
    
    public func close(){
        connection.cancel()
    }
    
    public static func validateIpAddress(ipToValidate: String) -> Bool {

        var sin = sockaddr_in()
        var sin6 = sockaddr_in6()

        if ipToValidate.withCString({ cstring in inet_pton(AF_INET6, cstring, &sin6.sin6_addr) }) == 1 {
            // IPv6 peer.
            return true
        }
        else if ipToValidate.withCString({ cstring in inet_pton(AF_INET, cstring, &sin.sin_addr) }) == 1 {
            // IPv4 peer.
            return true
        }

        return false;
    }
}
