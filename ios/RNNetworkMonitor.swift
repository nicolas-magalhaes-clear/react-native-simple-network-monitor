import Foundation
import SimpleNetworkMonitor

@objc(RNNetworkMonitor)
class RNNetworkMonitor: NSObject {
  private var monitor: NetworkMonitor?

  @objc
  func startMonitoring() {
    monitor = NetworkMonitor()
    monitor?.startMonitoring()
  }

  @objc
  func stopMonitoring() {
    monitor?.stopMonitoring()
  }

  @objc
  static func requiresMainQueueSetup() -> Bool {
    return false
  }

  override func supportedEvents() -> [String]! {
  return ["NetworkStatusChanged"]
  }

  func emitStatusChange(status: NetworkStatus) {
    let statusDict: [String: Any] = [
      "connectionType": status.connectionType.rawValue,
      "isCellular": status.isCellular,
      "packetLoss": status.packetLoss,
      "latency": status.latency,
      "isWiFi": status.isWiFi,
      "isEthernet": status.isEthernet,
      "isVPN": status.isVPN,
      "isAirplaneMode": status.isAirplaneMode,
      "isLowPowerMode": status.isLowPowerMode,
      "isRoaming": status.isRoaming,
    ]
    sendEvent(withName: "NetworkStatusChanged", body: statusDict)
  }
}
