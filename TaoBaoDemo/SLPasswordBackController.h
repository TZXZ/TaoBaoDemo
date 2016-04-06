//
//  SLPasswordBackController.h
//  TaoBaoDemo
//
//  Created by fang on 16/4/5.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLPasswordBackController : UIViewController <UITextFieldDelegate, NSURLSessionDataDelegate>
{
    UIButton *buttonSendSMS;
    UIButton *buttonNextStep;
    
    NSTimer *_timer;
    int numberTimeLeft;
}


@property (strong, nonatomic) UITextField *textFieldPhone;
@property (strong, nonatomic) UITextField *textFieldVerify;
@property (strong, nonatomic) NSMutableData *responseData;


@end
