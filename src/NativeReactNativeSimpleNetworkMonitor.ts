import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';
import type { NetworkStatusResult } from './types';

export interface Spec extends TurboModule {
  // Métodos assíncronos (Promise)
  startMonitoring(): Promise<void>;
  stopMonitoring(): Promise<void>;
  getCurrentStatus(): Promise<NetworkStatusResult>;

  // Para EventEmitter, precisamos adicionar listeners
  addListener(eventName: string): void;
  removeListeners(count: number): void;
}

export default TurboModuleRegistry.getEnforcing<Spec>(
  'ReactNativeSimpleNetworkMonitor'
);
