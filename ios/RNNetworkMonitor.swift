import Foundation
import SimpleNetworkMonitor
import React

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
    let statusString: String
    switch status {
    case .connectedViaWiFi:
      statusString = "wifi"
    case .connectedViaCellular:
      statusString = "cellular"
    case .disconnected:
      statusString = "disconnected"
    case .unknown:
      fallthrough
    default:
      statusString = "unknown"
    }

    sendEvent(withName: "NetworkStatusChanged", body: ["status": statusString])
  }
}
