#import "AppDelegate+PusherBeams.h"
#import "PusherBeams.h"
#import <UserNotifications/UserNotifications.h>

@import UserNotifications;
@import PushNotifications;

@interface AppDelegate () <UNUserNotificationCenterDelegate,
                           UIApplicationDelegate>
@end

@implementation AppDelegate (PusherBeams)

- (void)application:(UIApplication *)application
    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  [[PushNotifications shared] registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
    didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
  NSLog(@"Remote notification support is unavailable due to error: %@",
        error.localizedDescription);
}

- (void)application:(UIApplication *)application
    didReceiveRemoteNotification:(NSDictionary *)userInfo
          fetchCompletionHandler:
              (void (^)(UIBackgroundFetchResult))completionHandler {
  NSLog(@"COMING");
  [[PusherBeams pusherBeams] setNotification:userInfo];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  NSLog(@"notifications cleared");
}

@end
