#import <Cordova/CVDPlugin.h>

@interface PusherBeams: CDVPlugin

- (void)registerUserId:(CDVInvokedUrlCommand*)command;
- (void)clear:(CDVInvokedUrlCommand*)command;

@end
