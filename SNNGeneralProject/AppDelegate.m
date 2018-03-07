//
//  AppDelegate.m
//  SNNGeneralProject
//
//  Created by dzcx-shinana on 2017/11/22.
//  Copyright © 2017年 dzcx-shinana. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<WeiboSDKDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kWB_AppKey];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor=[UIColor whiteColor];

    HomeViewController *homeVC = [[HomeViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    nav.navigationBar.hidden = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WeiboSDK handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [WeiboSDK handleOpenURL:url delegate:self];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *userId = [(WBAuthorizeResponse *)response userID];
        NSString *accessToken = [(WBAuthorizeResponse *)response accessToken];
        
        NSLog(@"userId %@",userId);
        NSLog(@"accessToken %@",accessToken);
        
        NSDictionary *notification = @{
                                       @"userId" : userId,
                                       @"accessToken" : accessToken
                                       };
        [CommonParams shareInstance].userId = [notification objectForKeyCheck:@"userId"];
        [CommonParams shareInstance].accessToken = [notification objectForKeyCheck:@"accessToken"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"weiboDidLoginNotification"
                                                            object:self userInfo:notification];
    }
}

@end
