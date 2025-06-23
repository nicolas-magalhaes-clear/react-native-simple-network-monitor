#import "ReactNativeSimpleNetworkMonitor.h"
#import <React/RCTBridge.h>

@implementation ReactNativeSimpleNetworkMonitor

RCT_EXPORT_MODULE()

// MARK: - Turbo Module Methods

- (void)startMonitoring {
    // Chama o método Swift
    [self performSelector:@selector(startMonitoring)];
}

- (void)stopMonitoring {
    // Chama o método Swift
    [self performSelector:@selector(startMonitoring)];
}

- (void)getCurrentStatus:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject {
    // Chama o método Swift
    [self getCurrentStatus:<#^(id result)resolve#> reject:<#^(NSString *code, NSString *message, NSError *error)reject#>:resolve reject:reject];
}

// MARK: - EventEmitter Required Methods

- (NSArray<NSString *> *)supportedEvents {
    return @[@"onNetworkChange"];
}

- (void)addListener:(NSString *)eventName {
    [super addListener:eventName];
    // Opcional: lógica adicional quando adiciona listener
}

- (void)removeListeners:(double)count {
    [super removeListeners:count];
    // Opcional: lógica adicional quando remove listeners
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

// MARK: - Turbo Module Setup

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params {
    return std::make_shared<facebook::react::NativeReactNativeSimpleNetworkMonitorSpecJSI>(params);
}

@end
