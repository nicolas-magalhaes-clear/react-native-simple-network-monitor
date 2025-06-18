import { useEffect, useState } from "react";
import { NetworkStatus } from "./types";
import { NativeEventEmitter, NativeModules, Platform } from "react-native";

const DEFAULT_NETWORK_STATUS: NetworkStatus = {
  connectionType: "unknown",
  isCellular: false,
  isWiFi: false,
  isEthernet: false,
  latency: 0,
  packetLoss: 0,
  isVPN: false,
  isAirplaneMode: false,
  isLowPowerMode: false,
  isRoaming: false,
}

export const useNetwork = () => {
  const [networkStatus, setNetworkStatus] = useState<NetworkStatus>(DEFAULT_NETWORK_STATUS);

  useEffect(() => {
    const { RNNetworkMonitor} = NativeModules

    if(Platform.OS !== "ios" || !RNNetworkMonitor) {
      return
    }
    const emitter = new NativeEventEmitter(RNNetworkMonitor)

    const sub = emitter.addListener("NetworkStatusChanged", (status: NetworkStatus) => {
      setNetworkStatus(status)
    })

    return () => {
      sub.remove()
      RNNetworkMonitor.stopMonitoring()
    }
  }, [])

  return {networkStatus}
}