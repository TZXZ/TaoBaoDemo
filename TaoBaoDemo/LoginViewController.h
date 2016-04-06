//
//  LoginViewController.h
//  TaoBaoDemo
//
//  Created by fang on 16/3/18.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;

@interface LoginViewController : UIViewController <NSURLSessionDataDelegate>
{
    AppDelegate *appDelegate;
}


@property (strong, nonatomic) UIButton *buttonLogin;
@property (strong, nonatomic) NSMutableData *responseData;


@end
