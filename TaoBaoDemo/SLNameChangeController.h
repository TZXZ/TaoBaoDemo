//
//  SLNameChangeController.h
//  TaoBaoDemo
//
//  Created by fang on 16/4/7.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface SLNameChangeController : UIViewController <UITextFieldDelegate>
{
    AppDelegate *delegate;
}


@property (strong, nonatomic) UITextField *textFieldName;
@property (strong, nonatomic) UIButton *buttonNextStep;


@end
