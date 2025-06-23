#import "ReactNativeSimpleNetworkMonitor.h"
#import <React/RCTBridge.h>
#import <React/RCTEventEmitter.h>

// Forward declaration of the Swift class
@class ReactNativeSimpleNetworkMonitorSwift;

@interface ReactNativeSimpleNetworkMonitor ()
@property (nonatomic, strong) ReactNativeSimpleNetworkMonitorSwift *swiftInstance;
@end

@implementation ReactNativeSimpleNetworkMonitor

RCT_EXPORT_MODULE()

- (instancetype)init {
    self = [super init];
    if (self) {
        // Create the Swift instance
        Class swiftClass = NSClassFromString(@"ReactNativeSimpleNetworkMonitorSwift");
        if (swiftClass) {
            self.swiftInstance = [[swiftClass alloc] init];
        }
        
        // Listen for network status changes from Swift
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNetworkStatusChanged:)
                                                     name:@"ReactNativeSimpleNetworkMonitorStatusChanged"
                                                   object:nil];
    }
    return self;
}

- (void)handleNetworkStatusChanged:(NSNotification *)notification {
    if (self.hasListeners) {
        [self sendEventWithName:@"onNetworkChange" body:notification.object];
    }
}

RCT_EXPORT_METHOD(startMonitoring:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    if (self.swiftInstance) {
        [self.swiftInstance startMonitoringWithResolve:resolve reject:reject];
    } else {
        reject(@"error", @"Swift instance not available", nil);
    }
}

RCT_EXPORT_METHOD(stopMonitoring:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    if (self.swiftInstance) {
        [self.swiftInstance stopMonitoringWithResolve:resolve reject:reject];
    } else {
        reject(@"error", @"Swift instance not available", nil);
    }
}

RCT_EXPORT_METHOD(getCurrentStatus:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject) {
    if (self.swiftInstance) {
        [self.swiftInstance getCurrentStatusWithResolve:resolve reject:reject];
    } else {
        reject(@"error", @"Swift instance not available", nil);
    }
}

RCT_EXPORT_METHOD(addListener:(NSString *)eventName) {
    [super addListener:eventName];
}

RCT_EXPORT_METHOD(removeListeners:(double)count) {
    [super removeListeners:count];
}

- (NSArray<NSString *> *)supportedEvents {
    if (self.swiftInstance) {
        return [self.swiftInstance supportedEvents];
    }
    return @[@"onNetworkChange"];
}

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params {
    return std::make_shared<facebook::react::NativeReactNativeSimpleNetworkMonitorSpecJSI>(params);
}
#endif

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end 