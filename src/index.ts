import { NativeModules } from 'react-native'

export interface NetworkMonitorInterface {
  startMonitoring(): void
  stopMonitoring(): void
}

const { RNNetworkMonitor } = NativeModules

export default RNNetworkMonitor as NetworkMonitorInterface
