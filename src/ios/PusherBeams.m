#import "PusherBeams.h"

@import PushNotifications;
@import UserNotifications;

#pragma mark -
#pragma mark PusherBeams

@implementation PusherBeams

- (void)setUserId:(CDVInvokedUrlCommand*)command {
  [self.commandDelegate runInBackground:^{
    NSError *anyError;
    [[PushNotifications shared] addDeviceInterestWithInterest:@"debug-hello" error:&anyError];
  }];

  NSLog(@"setUserId completed");
  CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)getRegistrationState:(CDVInvokedUrlCommand*)command {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler: ^(UNNotificationSettings * _Nonnull settings){

    //1. Query the authorization status of the UNNotificationSettings object
      switch (settings.authorizationStatus) {
        case UNAuthorizationStatusAuthorized:
          NSLog(@"Status Authorized");
          return 'OKKK';
          break;
        case UNAuthorizationStatusDenied:
          NSLog(@"Status Denied");
          return 'Test'
          break;
        case UNAuthorizationStatusNotDetermined:
          NSLog(@"Undetermined");
          return 'Test2';
          break;
        default:
        break;
    }


    //2. To learn the status of specific settings, query them directly
    NSLog(@"Checking Badge settings");
    if (settings.badgeSetting == UNAuthorizationStatusAuthorized)
    NSLog(@"Yeah. We can badge this puppy!");
    else
    NSLog(@"Not authorized");
    }];
}

// Start instance and registerForRemoteNotifications
- (void)start:(CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{

        NSString *instanceId = [command argumentAtIndex:0];

        [[PushNotifications shared] startWithInstanceId:instanceId];
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
