"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.useNetwork = void 0;
const react_native_1 = require("react-native");
const use_network_1 = require("./use-network");
Object.defineProperty(exports, "useNetwork", { enumerable: true, get: function () { return use_network_1.useNetwork; } });
const { RNNetworkMonitor } = react_native_1.NativeModules;
exports.default = RNNetworkMonitor;
