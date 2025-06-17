#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNNetworkMonitor, NSObject)

RCT_EXTERN_METHOD(startMonitoring)
RCT_EXTERN_METHOD(stopMonitoring)

@end
