export interface NetworkStatusResult {
  isConnected: boolean;
  type: string;
  isInternetReachable: boolean;
  details: {
    strength?: number;
    ssid?: string;
    carrier?: string;
  };
}

export interface NetworkStatus {
  isConnected: boolean;
  type: 'wifi' | 'cellular' | 'unknown' | 'none';
  isInternetReachable: boolean | null;
  details: {
    strength?: number;
    ssid?: string;
    carrier?: string;
  };
}
