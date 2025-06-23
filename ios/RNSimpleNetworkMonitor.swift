import Foundation
import SimpleNetworkMonitor

@objc(ReactNativeSimpleNetworkMonitorSwift)
class ReactNativeSimpleNetworkMonitorSwift: NSObject {
    
    private let networkMonitor = NetworkMonitor.shared
    
    override init() {
        super.init()
        setupNetworkMonitor()
    }
    
    // MARK: - Swift Methods for Objective-C bridge
    
    @objc func startMonitoringWithResolve(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        networkMonitor.startMonitoring()
        resolve(nil)
    }

    @objc func stopMonitoringWithResolve(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        networkMonitor.stopMonitoring()
        resolve(nil)
    }

    @objc func getCurrentStatusWithResolve(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        let status = networkMonitor.currentStatus
        let result = createStatusDictionary(from: status)
        resolve(result)
    }
    
    @objc func supportedEvents() -> [String] {
        return ["onNetworkChange"]
    }
    
    private func setupNetworkMonitor() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .networkStatusDidChange,
            object: nil
        )
    }
    
    @objc private func networkStatusChanged(_ notification: Notification) {
        // This will be handled by the Objective-C module
        let status = networkMonitor.currentStatus
        let statusDict = createStatusDictionary(from: status)
        
        // Post notification that the Objective-C module can listen to
        NotificationCenter.default.post(
            name: NSNotification.Name("ReactNativeSimpleNetworkMonitorStatusChanged"),
            object: statusDict
        )
    }

    private func createStatusDictionary(from status: NetworkStatus) -> [String: Any] {
        return [
            "isConnected": status != .disconnected,
            "type": getTypeString(from: status),
            "isInternetReachable": status != .disconnected,
            "details": getDetails(from: status)
        ]
    }

    private func getTypeString(from status: NetworkStatus) -> String {
        switch status {
        case .connectedViaWiFi:
            return "wifi"
        case .connectedViaCellular:
            return "cellular"
        case .disconnected:
            return "none"
        case .unknown:
            return "unknown"
        }
    }

    private func getDetails(from status: NetworkStatus) -> [String: Any] {
        return [:]
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
