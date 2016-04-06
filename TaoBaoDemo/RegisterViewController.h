//
//  RegisterViewController.h
//  TaoBaoDemo
//
//  Created by fang on 16/3/19.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate, NSURLSessionDataDelegate>
{
    UIButton *buttonSendSMS;
    UIButton *buttonNextStep;
    UIButton *buttonRegister;
    NSTimer *_timer;
    int numberTimeLeft;
}

@property (strong, nonatomic) UITextField *textFieldPhone;
@property (strong, nonatomic) UITextField *textFieldVerify;
@property (strong, nonatomic) UITextField *textFieldName;
@property (strong, nonatomic) UITextField *textFieldPassword1;
@property (strong, nonatomic) UITextField *textFieldPassword2;

@property (strong, nonatomic) NSMutableData *responseData;


@end
