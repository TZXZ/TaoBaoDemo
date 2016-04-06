//
//  AppDelegate.m
//  TaoBaoDemo
//
//  Created by fang on 16/1/22.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MicroViewController.h"
#import "CommunityViewController.h"
#import "CartViewController.h"
#import "UserViewController.h"
#import <SMS_SDK/SMSSDK.h>


//SMSSDK提供的key
#define appkey @"10acd9e36f2ab"
#define app_secrect @"c5f59080a700fa82bc2535fb3171d0ce"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    self.userHasLogin = NO;
    self.userInfomation = [[UserInfomation alloc] init];
    _numberOfGoods = 10001;
    _arrayForCart = [[NSMutableArray alloc] init];
    
    //初始化短信验证码
    [SMSSDK registerApp:appkey withSecret:app_secrect];
    
    //初始化第一个视图控制器
    MainViewController *mainViewController = [[MainViewController alloc] init];
    mainViewController.tabBarItem.image = [[UIImage imageNamed:@"shouye.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"shouye1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainViewController.tabBarItem.title = @"首页";
    
    //初始化第二个视图控制器
    MicroViewController *microViewController = [[MicroViewController alloc] init];
    microViewController.tabBarItem.image = [[UIImage imageNamed:@"weitao.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    microViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"weitao1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    microViewController.tabBarItem.title = @"微淘";
    
    
    //初始化第三个视图控制器
    CommunityViewController *communityViewController = [[CommunityViewController alloc] init];
    communityViewController.tabBarItem.image = [[UIImage imageNamed:@"shequ.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    communityViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"shequ1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    communityViewController.tabBarItem.title = @"社区";
    
    //初始化第四个视图控制器
    CartViewController *cartViewController = [[CartViewController alloc] init];
    cartViewController.tabBarItem.image = [[UIImage imageNamed:@"gouwuche.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cartViewController.tabBarItem.selectedImage =[[UIImage imageNamed:@"gouwuche1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    cartViewController.tabBarItem.title = @"购物车";
    
    
    //初始化第五个视图控制器
    UserViewController *userViewController = [[UserViewController alloc] init];
    userViewController.tabBarItem.image = [[UIImage imageNamed:@"yonghu.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"yonghu1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userViewController.tabBarItem.title = @"我的淘宝";
    UINavigationController *userNavController = [[UINavigationController alloc] initWithRootViewController:userViewController];
    
    NSArray *arrayControllers = @[mainViewController,microViewController,communityViewController,cartViewController,userNavController];
    tabBarController.viewControllers = arrayControllers;
    self.window.rootViewController = tabBarController;
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
