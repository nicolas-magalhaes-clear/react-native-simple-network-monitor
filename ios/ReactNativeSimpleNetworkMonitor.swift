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
    
    // MARK: - Turbo Module Methods
    @objc
    func startMonitoring() {
        networkMonitor.startMonitoring()
    }
    
    @objc
    func stopMonitoring() {
        networkMonitor.stopMonitoring()
    }
    
    @objc
    func getCurrentStatus(_ resolve: @escaping RCTPromiseResolveBlock,
                         reject: @escaping RCTPromiseRejectBlock) {
        let status = networkMonitor.currentStatus
        let result = createStatusDictionary(from: status)
        resolve(result)
    }
    
    // MARK: - EventEmitter
    override func supportedEvents() -> [String]! {
        return ["onNetworkChange"]
    }
    
    override class func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    // MARK: - Private Methods
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
        // Adicione detalhes específicos conforme necessário
        return [:]
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
        let status = networkMonitor.currentStatus
        let statusDict = createStatusDictionary(from: status)
        sendEvent(withName: "onNetworkChange", body: statusDict)
    }
}


extension ReactNativeSimpleNetworkMonitor {
    
    @objc
    func startMonitoringSwift() {
        startMonitoring()
    }
    
    @objc
    func stopMonitoringSwift() {
        stopMonitoring()
    }
    
    @objc
    func getCurrentStatusSwift(_ resolve: @escaping RCTPromiseResolveBlock,
                              reject: @escaping RCTPromiseRejectBlock) {
        getCurrentStatus(resolve, reject: reject)
    }
}
