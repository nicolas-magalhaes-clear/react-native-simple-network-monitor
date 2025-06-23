import Foundation
import React
import SimpleNetworkMonitor

@objc(ReactNativeSimpleNetworkMonitor)
class ReactNativeSimpleNetworkMonitor: RCTEventEmitter {
    
    private let networkMonitor = NetworkMonitor.shared
    
    override init() {
        super.init()
        setupNetworkMonitor()
    }
    
    // MARK: - React Native Module
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    // MARK: - EventEmitter
    override func supportedEvents() -> [String]! {
        return ["onNetworkChange"]
    }
    
    // MARK: - Exported Methods
    @objc
    func startMonitoring(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        networkMonitor.startMonitoring()
        resolve(nil)
    }

    @objc
    func stopMonitoring(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        networkMonitor.stopMonitoring()
        resolve(nil)
    }

    @objc
    func getCurrentStatus(_ resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        let status = networkMonitor.currentStatus
        let result = createStatusDictionary(from: status)
        resolve(result)
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
        guard hasListeners else { return }
        let status = networkMonitor.currentStatus
        let statusDict = createStatusDictionary(from: status)
        sendEvent(withName: "onNetworkChange", body: statusDict)
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
