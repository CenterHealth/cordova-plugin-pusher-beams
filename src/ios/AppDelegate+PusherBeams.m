#import "AppDelegate+PusherBeams.h"
#import "PusherBeams.h"

@import UserNotifications;
@import PushNotifications;

@implementation AppDelegate (PusherBeams)

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[PushNotifications shared] registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Remote notification support is unavailable due to error: %@", error.localizedDescription);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification: (NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
   NSLog(@"%@", userInfo);
}

@end
