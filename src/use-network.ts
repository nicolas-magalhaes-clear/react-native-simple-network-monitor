import { useEffect, useRef, useState } from "react";
import type { NetworkStatus, NetworkStatusResult } from "./types";
import { NativeEventEmitter, Platform } from "react-native";
import NativeReactNativeSimpleNetworkMonitor from "./NativeReactNativeSimpleNetworkMonitor";

export function useNetwork(){
  const [networkStatus, setNetworkStatus] = useState<NetworkStatus>({
    isConnected: false,
    type: 'unknown',
    isInternetReachable: null,
    details: {},
  });

  const [isLoading, setIsLoading] = useState(true);
  const eventEmitterRef = useRef<NativeEventEmitter | null>(null);
  const subscriptionRef = useRef<any>(null);

  const convertNativeStatus = (nativeStatus: NetworkStatusResult): NetworkStatus => {
    return {
      isConnected: nativeStatus.isConnected,
      type: (nativeStatus.type as NetworkStatus['type']) || 'unknown',
      isInternetReachable: nativeStatus.isInternetReachable,
      details: nativeStatus.details || {},
    };
  };

  useEffect(() => {
    if (Platform.OS === 'ios') {
      // Para Turbo Modules, criamos EventEmitter com o módulo nativo
      eventEmitterRef.current = new NativeEventEmitter(
        NativeReactNativeSimpleNetworkMonitor as any
      );
    }

    // Função para processar mudanças de rede
    const handleNetworkChange = (data: NetworkStatusResult) => {
      const convertedStatus = convertNativeStatus(data);
      setNetworkStatus(convertedStatus);
      setIsLoading(false);
    };

    // Obter status inicial
    const getInitialStatus = async () => {
      try {
        const initialStatus = await NativeReactNativeSimpleNetworkMonitor.getCurrentStatus();
        handleNetworkChange(initialStatus);
      } catch (error) {
        console.warn('Failed to get initial network status:', error);
        setIsLoading(false);
      }
    };

    // Configurar listener para mudanças (só no iOS por enquanto)
    if (eventEmitterRef.current) {
      subscriptionRef.current = eventEmitterRef.current.addListener(
        'onNetworkChange',
        handleNetworkChange
      );
    }

    // Iniciar monitoramento
    NativeReactNativeSimpleNetworkMonitor.startMonitoring();
    
    // Obter status inicial
    getInitialStatus();

    // Cleanup
    return () => {
      if (subscriptionRef.current) {
        subscriptionRef.current.remove();
      }
      NativeReactNativeSimpleNetworkMonitor.stopMonitoring();
    };
  }, []);


  const refresh = async (): Promise<NetworkStatus> => {
    try {
      const status = await NativeReactNativeSimpleNetworkMonitor.getCurrentStatus();
      const convertedStatus = convertNativeStatus(status);
      setNetworkStatus(convertedStatus);
      return convertedStatus;
    } catch (error) {
      console.warn('Failed to refresh network status:', error);
      throw error;
    }
  };

  return {
    ...networkStatus,
    isLoading,
    refresh,
  };


}