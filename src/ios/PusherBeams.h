#import <Cordova/CDVPlugin.h>

@interface PusherBeams: CDVPlugin

- (void)getRegistrationState: (CDVInvokedUrlCommand*)command;
- (void)start: (CDVInvokedUrlCommand*)command;
- (void)setUserId:(CDVInvokedUrlCommand*)command;
- (void)clear:(CDVInvokedUrlCommand*)command;

@end
