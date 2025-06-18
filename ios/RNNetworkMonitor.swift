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
        NetworkMonitor.shared.startMonitoring()
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

    func networkStatusDidChange(_ status: NetworkStatus) {
        let statusData: [String: Any] = [
            "status": status.rawValue,
            "isConnected": status != .disconnected && status != .unknown
        ]
        sendEvent(withName: "NetworkStatusChanged", body: statusData)
    }
}
