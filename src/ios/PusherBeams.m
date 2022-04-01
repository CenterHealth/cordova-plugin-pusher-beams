#import "PusherBeams.h"

@import PushNotifications;
@import UserNotifications;

#pragma mark -
#pragma mark PusherBeams

@implementation PusherBeams

- (void)setUserId:(CDVInvokedUrlCommand*)command {
  [self.commandDelegate runInBackground:^{
    NSError *anyError
    [[PushNotifications shared] addDeviceInterestWithInterest:@"debug-hello" error:&anyError];
  }];

  NSLog(@"setUserId completed");
  CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)getRegistrationState:(CDVInvokedUrlCommand*)command {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler: ^(UNNotificationSettings *settings){
        return settings.authorizationStatus;
    }];
}

// Start instance and registerForRemoteNotifications
- (void)start:(CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{

        NSString *instanceId = [command argumentAtIndex:0];

        [[PushNotifications shared] startWithInstanceId:@"%@",instanceId];
        [[PushNotifications shared] registerForRemoteNotifications];
    }];

  NSLog(@"registerForRemoteNotifications completed");
  CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

// Clear all states
- (void)clear:(CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
        [PushNotificationsStatic clearAllStateWithCompletion:^{}];
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}
@end
