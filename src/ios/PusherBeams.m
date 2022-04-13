#import "PusherBeams.h"

@import PushNotifications;
@import UserNotifications;

#pragma mark -
#pragma mark PusherBeams

@implementation PusherBeams

static NSDictionary *notification; // used for Apple Sign In
static PusherBeams *pusherBeams;

+ (PusherBeams *)pusherBeams {
  return pusherBeams;
}

- (void)pluginInitialize {
  NSLog(@"Starting Firebase plugin");
  pusherBeams = self;
}

- (void)setUserId:(CDVInvokedUrlCommand *)command {
  BeamsTokenProvider *beamsTokenProvider = [[BeamsTokenProvider alloc]
      initWithAuthURL:[command argumentAtIndex:0]
          getAuthData:^AuthData *_Nonnull {
            NSString *sessionToken = [command argumentAtIndex:2];
            NSDictionary *headers = @{
              @"Authorization" :
                  [NSString stringWithFormat:@"Bearer %@", sessionToken]
            }; // Headers your auth endpoint needs
            NSDictionary *queryParams =
                @{}; // URL query params your auth endpoint needs

            return [[AuthData alloc] initWithHeaders:headers
                                         queryParams:queryParams];
          }];

  [[PushNotifications shared]
          setUserId:[command argumentAtIndex:1]
      tokenProvider:beamsTokenProvider
         completion:^(NSError *_Nullable anyError) {
           if (anyError) {
             NSLog(@"Error: %@", anyError);
           } else {
             NSLog(@"Successfully authenticated with Pusher Beams");
           }
           CDVPluginResult *result =
               [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
           [self.commandDelegate sendPluginResult:result
                                       callbackId:command.callbackId];
         }];
}

- (void)getRegistrationState:(CDVInvokedUrlCommand *)command {
  UNUserNotificationCenter *center =
      [UNUserNotificationCenter currentNotificationCenter];

  __block NSString *authResult;
  [center getNotificationSettingsWithCompletionHandler:^(
              UNNotificationSettings *_Nonnull settings) {
    switch (settings.authorizationStatus) {
    case UNAuthorizationStatusAuthorized:
      NSLog(@"Status Authorized");
      authResult = @"Authorized";
      break;
    case UNAuthorizationStatusDenied:
      NSLog(@"Status Denied");
      authResult = @"Denied";
      break;
    case UNAuthorizationStatusNotDetermined:
      NSLog(@"Undetermined");
      authResult = @"Undetermined";
      break;
    default:
      break;
    }
    CDVPluginResult *result =
        [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                          messageAsString:authResult];
    [self.commandDelegate sendPluginResult:result
                                callbackId:command.callbackId];
  }];
}

// Start instance and registerForRemoteNotifications
- (void)start:(CDVInvokedUrlCommand *)command {
  [self.commandDelegate runInBackground:^{
    NSLog(@"beams starting");
    NSString *instanceId = [command argumentAtIndex:0];

    [[PushNotifications shared] startWithInstanceId:instanceId];
    [[PushNotifications shared] registerForRemoteNotifications];
    NSLog(@"registerForRemoteNotifications completed");
    CDVPluginResult *result =
        [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result
                                callbackId:command.callbackId];
  }];
}

// Clear all states
- (void)clear:(CDVInvokedUrlCommand *)command {
  [self.commandDelegate runInBackground:^{
    [PushNotificationsStatic clearAllStateWithCompletion:^{
    }];
    CDVPluginResult *result =
        [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:result
                                callbackId:command.callbackId];
  }];
}

- (void)getNotification:(CDVInvokedUrlCommand *)command {
  CDVPluginResult *result =
      [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                    messageAsDictionary:notification];
  [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)setNotification:(NSDictionary *)userInfo {
  notification = userInfo;
  return;
}

- (void)clearNotification {
  notification = nil;
  return;
}

@end
