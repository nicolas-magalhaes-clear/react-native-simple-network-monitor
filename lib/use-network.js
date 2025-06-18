"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.useNetwork = void 0;
const react_1 = require("react");
const react_native_1 = require("react-native");
const DEFAULT_NETWORK_STATUS = {
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
};
const useNetwork = () => {
    const [networkStatus, setNetworkStatus] = (0, react_1.useState)(DEFAULT_NETWORK_STATUS);
    (0, react_1.useEffect)(() => {
        const { RNNetworkMonitor } = react_native_1.NativeModules;
        if (react_native_1.Platform.OS === "ios" || !RNNetworkMonitor) {
            return;
        }
        const emitter = new react_native_1.NativeEventEmitter(RNNetworkMonitor);
        const sub = emitter.addListener("NetworkStatusChanged", (status) => {
            setNetworkStatus(status);
        });
        return () => {
            sub.remove();
            RNNetworkMonitor.stopMonitoring();
        };
    }, []);
    return { networkStatus };
};
exports.useNetwork = useNetwork;
