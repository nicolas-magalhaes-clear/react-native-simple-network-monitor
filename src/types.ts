export type NetworkStatus = {
  connectionType: string;
  isCellular: boolean;
  isWiFi: boolean;
  isEthernet: boolean;
  latency: number;
  packetLoss: number;
  isVPN: boolean;
  isAirplaneMode: boolean;
  isLowPowerMode: boolean;
  isRoaming: boolean;
}

export interface NetworkMonitorInterface {
  startMonitoring(): void
  stopMonitoring(): void
}