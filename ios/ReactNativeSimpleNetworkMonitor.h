#import <React/RCTEventEmitter.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import <ReactNativeSimpleNetworkMonitorSpec/ReactNativeSimpleNetworkMonitorSpec.h>
@interface ReactNativeSimpleNetworkMonitor : RCTEventEmitter <NativeReactNativeSimpleNetworkMonitorSpec>
#else
@interface ReactNativeSimpleNetworkMonitor : RCTEventEmitter
#endif

@end 