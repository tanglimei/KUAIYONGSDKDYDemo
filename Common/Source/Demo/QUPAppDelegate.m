//
//  AppDelegate.m
//  QuickUnifyPlatformDemo
//
//  Created by yuhao on 15/6/15.
//  Copyright (c) 2015年 yuhao. All rights reserved.
//

#import "QUPAppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <QuickUnifyPlatform/QuickUnifyPlatform.h>
@interface QUPAppDelegate ()

@end

@implementation QUPAppDelegate

//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    // UIInterfaceOrientationMaskAll
//    // it is the safest way of doing it:
//    // - GameCenter and some other services might have portrait-only variant
//    //     and will throw exception if portrait is not supported here
//    // - When you change allowed orientations if you end up forbidding current one
//    //     exception will be thrown
//    // Anyway this is intersected with values provided from UIViewController, so we are good
//    //改成UIInterfaceOrientationMaskAll是必要的 ipad上照相和银联支付竖屏支持。
//    return UIInterfaceOrientationMaskAll;
//    //return UIInterfaceOrientationMaskLandscape;
//    //	return   (1 << UIInterfaceOrientationPortrait) | (1 << UIInterfaceOrientationPortraitUpsideDown)
//    //		   | (1 << UIInterfaceOrientationLandscapeRight) | (1 << UIInterfaceOrientationLandscapeLeft);
//}




//TODO: 必须添加代码开始....
- (void)applicationWillEnterForeground:(UIApplication *)application
{
 
    [[QuickUnifyPlatform getInstance] qupOnPause];
    //Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
   [[QuickUnifyPlatform getInstance] qupHandleWithapplication:application openURL:url sourceApplication:nil annotation:nil];
    return YES;
}

#ifdef __IPHONE_9_0
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options{
    [[QuickUnifyPlatform getInstance] qupHandleWithapplication:app openURL:url sourceApplication:[options valueForKey:@"UIApplicationOpenURLOptionsSourceApplicationKey"] annotation:[options valueForKey:@"UIApplicationOpenURLOptionsAnnotationKey"]];
    
    return YES;
}

#else
//Deprecated in iOS 9.0.
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{

    [[QuickUnifyPlatform getInstance] qupHandleWithapplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    
    return YES;
}
#endif
//TODO: 必须添加代码结尾....


//start 以下代码用于获取游戏信息。实际游戏中不有添加

- (NSString *) qupMD5Hash :(NSString *)str{
    int i = 0;
    NSMutableString *cryptedString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    const char *string = [str UTF8String];
    CC_MD5(string, (CC_LONG)strlen(string), result);
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [cryptedString appendFormat:@"%02x", result[i]];
    }
    return cryptedString;
    
}
- (void)getQuickUnifyPlatform{
    NSString * bundlePath = [[NSBundle mainBundle] pathForResource:@"Frameworks/QuickUnifyPlatform.framework" ofType:@""];
    NSBundle *frameworkBundle = [NSBundle bundleWithPath:bundlePath];
     NSLog(@"bundlePath:%@,frameworkBundle:%@",bundlePath,frameworkBundle);
    if (frameworkBundle && [frameworkBundle load]) {
        Class platformClass= NSClassFromString(@"QuickUnifyPlatform");
        Class productClass= NSClassFromString(@"QuickProductInfo");
        NSLog(@"platformClass:%@",platformClass);
        NSLog(@"productClass:%@",productClass);
    }
   
}
- (void)getManifestPlist{
 
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"QuickManifest" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSString *secrtkey = @"36114fa2049936aa220c5b856d20c270";
    NSString *union_id = [data objectForKey:@"plat"] ;
    NSString *game_id =[data objectForKey:@"gameid"] ;
    NSString *sign =
    [[self qupMD5Hash:[NSString stringWithFormat:@"%@game_id=%@&union_id=%@",secrtkey,game_id,union_id]]lowercaseString];
    
    NSString *infoUrl=kQUPPlistURL;
    if([[[[QuickUnifyPlatform getInstance] qupSettingInfo] objectForKey:@"isdebug"] boolValue]){
        infoUrl=kQUPDebugPlistURL;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@?union_id=%@&game_id=%@&type=1&sign=%@",infoUrl,union_id,game_id,sign];
    
    NSLog(@"urlString:%@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"GET"];
    NSOperationQueue *queue=[NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *jsonError=nil;
        NSDictionary* responseDic=nil;
        if(data!=nil){
            responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        }
        if(connectionError!=nil){
            NSLog(@"connectionError:%@",connectionError);
        }else if(jsonError!=nil){
          NSLog(@"jsonError:%@",jsonError);
            
        }else if(responseDic!=nil){
            NSLog(@"responseDic:%@",responseDic);
        }else{
            NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"dataStr:%@",dataStr);
        }
    }];
}
//end

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8){
        //ios8注册推送
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
                                                                                             |UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else{
        //register to receive notifications
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
    }
    //一下方法用于测试不用添加
    //[self getManifestPlist];
    //[self getQuickUnifyPlatform];
    
    
    return YES;
}

#ifdef __IPHONE_8_0
//ios8需要调用内容
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
        
    }
}

#endif

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"设备令牌: %@", deviceToken);
    NSString *tokeStr = [NSString stringWithFormat:@"%@",deviceToken];
    if ([tokeStr length] == 0) {
        return;
    }
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    //以警告框的方式来显示推送消息
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"经过推送发送过来的消息"
                                                        message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                       delegate:self
                                              cancelButtonTitle:@"关闭"
                                              otherButtonTitles:@"处理",nil];
        [alert show];
    }
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"注册推送服务时，发生以下错误： %@",error);
}


- (void)application:(UIApplication*)application didReceiveLocalNotification:(UILocalNotification*)notification
{
  
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
