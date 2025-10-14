//
//  AppDelegate.m
//  Popover
//
//  Created by chiuyifan on 2025/9/25.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
//    // 1. 设置选中状态的背景 (Correct)
//    UIImage *selectImage = [UIImage imageNamed:@"selectBG"];
//    [[UISegmentedControl appearance] setBackgroundImage:selectImage
//                                                  forState:UIControlStateSelected
//                                                barMetrics:UIBarMetricsDefault];
//    
//    // 2. 设置未选中状态的背景 (Corrected)
//    UIImage *UnselectImage = [UIImage imageNamed:@"UnselectBG"];
//    [[UISegmentedControl appearance] setBackgroundImage:UnselectImage
//                                                  forState:UIControlStateNormal
//                                                barMetrics:UIBarMetricsDefault];
//    
     
    return YES;
    
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    // select
//    
//}
- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    
    
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    
}


@end
