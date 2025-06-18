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
    const { RNNetworkMonitor } = NativeModules

    console.log("Platform:", Platform.OS);
    console.log("RNNetworkMonitor available:", !!RNNetworkMonitor);

    if (Platform.OS !== "ios" || !RNNetworkMonitor) {
      console.log("Early return - not iOS or no module");
      return
    }

    const emitter = new NativeEventEmitter(RNNetworkMonitor)
    console.log("Emitter created");

    const sub = emitter.addListener("NetworkStatusChanged", (data: any) => {
      console.log("✅ Received network status:", data);
      setNetworkStatus(data)
    })

    console.log("Listener added");

    // Adicionar um pequeno delay para garantir que o listener está configurado
    const timer = setTimeout(() => {
      console.log("Starting monitoring...");
      RNNetworkMonitor.startMonitoring()
    }, 100);

    return () => {
      clearTimeout(timer);
      console.log("Cleanup - removing listener and stopping monitoring");
      sub.remove()
      RNNetworkMonitor.stopMonitoring()
    }
  }, [])

  return { networkStatus }
}