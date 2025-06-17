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
}
