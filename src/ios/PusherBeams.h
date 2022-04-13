#import <Cordova/CDVPlugin.h>

@interface PusherBeams: CDVPlugin

- (void)getRegistrationState: (CDVInvokedUrlCommand*)command;
- (void)start: (CDVInvokedUrlCommand*)command;
- (void)setUserId:(CDVInvokedUrlCommand*)command;
- (void)clear:(CDVInvokedUrlCommand*)command;
- (void)getNotification:(CDVInvokedUrlCommand*)command;
- (void)setNotification:(NSString*)userInfo;
- (void)clearNotification;

@property NSString *notification;

@end
