import Foundation
import React
import SimpleNetworkMonitor

@objc(RNNetworkMonitor)
class RNNetworkMonitor: RCTEventEmitter, NetworkMonitorDelegate {

    override init() {
        super.init()
        NetworkMonitor.shared.delegate = self
    }

    @objc
func startMonitoring() {
    print("📱 Swift: startMonitoring called")
    NetworkMonitor.shared.startMonitoring()
}

func networkStatusDidChange(_ status: NetworkStatus) {
    print("📱 Swift: networkStatusDidChange called with status: \(status)")
    let statusData: [String: Any] = [
        "status": status.rawValue,
        "isConnected": status != .disconnected && status != .unknown
    ]
    print("📱 Swift: sending event with data: \(statusData)")
    sendEvent(withName: "NetworkStatusChanged", body: statusData)
}

    @objc
    func stopMonitoring() {
        NetworkMonitor.shared.stopMonitoring()
    }

    override class func requiresMainQueueSetup() -> Bool {
        return true
    }

    override func supportedEvents() -> [String]! {
        return ["NetworkStatusChanged"]
    }

    
}
