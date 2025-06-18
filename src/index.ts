import { NativeModules } from 'react-native'
import { NetworkMonitorInterface } from './types'
import { useNetwork } from './use-network'

const { RNNetworkMonitor } = NativeModules

export default RNNetworkMonitor as NetworkMonitorInterface
export { NetworkMonitorInterface, useNetwork }
