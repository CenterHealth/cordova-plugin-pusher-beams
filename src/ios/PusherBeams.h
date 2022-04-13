#import <Cordova/CDVPlugin.h>

@interface PusherBeams : CDVPlugin
+ (PusherBeams *)pusherBeams;
- (void)getRegistrationState:(CDVInvokedUrlCommand *)command;
- (void)start:(CDVInvokedUrlCommand *)command;
- (void)setUserId:(CDVInvokedUrlCommand *)command;
- (void)clear:(CDVInvokedUrlCommand *)command;
- (void)getNotification:(CDVInvokedUrlCommand *)command;
- (void)setNotification:(NSDictionary *)userInfo;
- (void)clearNotification;
@end
