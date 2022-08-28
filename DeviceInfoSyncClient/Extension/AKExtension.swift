//
//  AKExtension.swift
//  DeviceInfoSyncClient
//
//  Created by Kim on 8/28/22.
//
//  Because the structure of Kyome22's Activity Kit does not support codable,
//  I don't want to modify his code without authorization, so I wrote this extension for serialization
//

import Foundation
import ActivityKit


public struct ActivityInfo : Codable{
    //cpu
    public var cpuPercentage: Double = 0.0
    public var cpuSystem: Double = 0.0
    public var cpuUser: Double = 0.0
    public var cpuIdle: Double = 0.0
    
    //memory
    public var memoryPercentage: Double = 0.0
    public var memoryPressure: Double = 0.0
    public var memoryApp: Double = 0.0
    public var memoryWired: Double = 0.0
    public var memoryCompressed: Double = 0.0
    
    //Disk
    public var diskPercentage: Double = 0.0
    public var diskTotal = "0.0 GB"
    public var diskFree = "0.0 GB"
    public var diskUsed = "0.0 GB"
    
    //Network
    public var networkName: String = "no connection"
    public var networkLocalIP: String = ""
    public var networkUpload = "0.0KB/s"
    public var networkDownload = "0.0KB/s"
    
    //Battery
    public var batteryPercentage: Double = 0.0
    public var batteryPowerSource: String = "Unknown"
    public var batreryHealth: Double = 0.0
    public var batteryCycle: Int = 0
    public var batteryTemperature: Double = 0.0
}


public extension ActivityObserver{
    func toJSON() -> String? {
        let data = ActivityInfo(cpuPercentage: cpuUsage.percentage, cpuSystem: cpuUsage.system, cpuUser: cpuUsage.user, cpuIdle: cpuUsage.idle,
                                memoryPercentage: memoryPerformance.percentage, memoryPressure: memoryPerformance.pressure, memoryApp: memoryPerformance.app, memoryWired: memoryPerformance.wired, memoryCompressed: memoryPerformance.compressed,
                                diskPercentage: diskCapacity.percentage, diskTotal: diskCapacity.total.toString(), diskFree: diskCapacity.free.toString(), diskUsed: diskCapacity.used.toString(),
                                networkName: networkConnection.name, networkLocalIP: networkConnection.localIP, networkUpload: networkConnection.upload.toString(), networkDownload: networkConnection.download.toString(),
                                batteryPercentage: batteryStatus.percentage, batteryPowerSource: batteryStatus.powerSource, batreryHealth: batteryStatus.health,batteryCycle: batteryStatus.cycle,batteryTemperature: batteryStatus.temperature
        )
        do {
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let json = try encoder.encode( data )
            return String(data: json, encoding: .utf8)!
        } catch let error {
            print("error converting to json: \(error)")
            return nil
        }
    }
}


public extension ByteData{
    func toString()->String{
        let format = "%.1f %@"
        return String(format: format, value,unit)
    }
}

public extension PacketData{
    func toString()->String{
        let format = "%.1f %@"
        return String(format: format, value,unit)
    }
}
