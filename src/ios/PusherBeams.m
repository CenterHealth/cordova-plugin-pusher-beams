#import "PusherBeams.h"

@import PushNotifications;
@import UserNotifications;

#pragma mark -
#pragma mark PusherBeams

@implementation PusherBeams

- (void)setUserId:(CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
        NSString *tokenUrl = [command argumentAtIndex:0];
        NSString *userId = [command argumentAtIndex:1];
        if ([userId isEqualToString:@"null"]) {
            //dont register yet - there is no userid
            return;
        }
        NSString *authToken= [command argumentAtIndex:2];
        NSString *bearerToken = [NSString stringWithFormat:@"Bearer %@", authToken];
        BeamsTokenProvider *tokenProvider = [[BeamsTokenProvider alloc] initWithAuthURL:tokenUrl getAuthData:^AuthData *{
            NSDictionary *headers = @{
                @"Authorization" : bearerToken
            };
            AuthData *toRet = [[AuthData alloc] initWithHeaders:headers queryParams:@{}];
            return toRet;
        }];
        [PushNotificationsStatic setUserId:userId tokenProvider:tokenProvider completion:^(NSError *error) {
            if (error != nil) {
                NSLog(@"%@", error);
            }
        }];
    }];
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)getRegistrationState:(CDVInvokedUrlCommand*)command {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

    __block NSString *authResult;
    [center getNotificationSettingsWithCompletionHandler: ^(UNNotificationSettings * _Nonnull settings){

      switch (settings.authorizationStatus) {
        case UNAuthorizationStatusAuthorized:
          NSLog(@"Status Authorized");
          authResult=@"Authorized";
          break;
        case UNAuthorizationStatusDenied:
          NSLog(@"Status Denied");
          authResult=@"Denied";
          break;
        case UNAuthorizationStatusNotDetermined:
          NSLog(@"Undetermined");
          authResult=@"Undetermined";
          break;
        default:
        break;
      }
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:authResult];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

// Start instance and registerForRemoteNotifications
- (void)start:(CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{

        NSString *instanceId = [command argumentAtIndex:0];

        [[PushNotifications shared] startWithInstanceId:instanceId];
        [[PushNotifications shared] registerForRemoteNotifications];
        NSLog(@"registerForRemoteNotifications completed");
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
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
