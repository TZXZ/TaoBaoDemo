//
//  SLPasswordBackController.m
//  TaoBaoDemo
//
//  Created by fang on 16/4/5.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLPasswordBackController.h"
#import <SMS_SDK/SMSSDK.h>

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height

@interface SLPasswordBackController ()

@end

@implementation SLPasswordBackController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"找回密码";
    self.view.frame = [[UIScreen mainScreen] bounds];
    
//新建手机号、验证码、和获取验证码按钮
    int tempL = WL / 2;
    self.textFieldPhone.delegate = self;
    self.textFieldPhone = [[UITextField alloc] initWithFrame:CGRectMake(tempL - 150, 100, 300, 40)];
    self.textFieldPhone.placeholder = @"请输入手机号码";
    self.textFieldPhone.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldPhone.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageViewPhone = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageViewPhone.image = [UIImage imageNamed:@"label_phone.png"];
    self.textFieldPhone.leftView = imageViewPhone;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 300, 1)];
    line.backgroundColor = [UIColor grayColor];
    [self.textFieldPhone addSubview:line];
    [self.view addSubview:self.textFieldPhone];      //添加请输入手机号码文本框
    
    self.textFieldVerify = [[UITextField alloc] initWithFrame:CGRectMake(tempL - 150, 160, 300, 40)];
    self.textFieldVerify.placeholder = @"请输入验证码";
    self.textFieldVerify.keyboardType = UIKeyboardTypeNumberPad;
    self.textFieldVerify.rightViewMode = UITextFieldViewModeAlways;
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 300, 1)];
    line2.backgroundColor = [UIColor grayColor];
    [self.textFieldVerify addSubview:line2];
    buttonSendSMS = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSendSMS.frame = CGRectMake(0, 0, 110, 30);
    buttonSendSMS.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [buttonSendSMS setTitle:@"获取验证码" forState:UIControlStateNormal];
    buttonSendSMS.backgroundColor = [UIColor colorWithRed:78/255.0 green:198/255.0 blue:56/255.0 alpha:1];
    self.textFieldVerify.rightView = buttonSendSMS;
    //buttonSendSMS.clipsToBounds = YES;
    buttonSendSMS.layer.cornerRadius = 5.0f;
    [buttonSendSMS addTarget:self action:@selector(buttonSendSMS) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.textFieldVerify];          //添加验证码输入框和获取按钮
    
    //初始化下一步按钮
    buttonNextStep = [[UIButton alloc] initWithFrame:CGRectMake(20, 220, WL - 40, 40)];
    buttonNextStep.backgroundColor = [UIColor colorWithRed:78/255.0 green:198/255.0 blue:56/255.0 alpha:1];
    buttonNextStep.enabled = NO;
    buttonNextStep.layer.cornerRadius = 6;
    buttonNextStep.layer.masksToBounds = YES;
    [buttonNextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [buttonNextStep addTarget:self action:@selector(buttonNextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonNextStep];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark -- button 相关事件
- (void)buttonSendSMS
{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.textFieldPhone.text zone:@"86" customIdentifier:nil result:^(NSError *error)
     {
         if (!error)
         {
             //发送验证码成功的回调
             buttonNextStep.enabled = YES;
             numberTimeLeft = 60;
             buttonSendSMS.enabled = NO;
             _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerBegan) userInfo:nil repeats:YES];
             buttonSendSMS.backgroundColor = [UIColor grayColor];
             
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"成功请求发送验证码" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
             [alertController addAction:okAction];
             [self presentViewController:alertController animated:YES completion:nil];
         }
         else
         {
             //发送验证码失败的回调
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号码" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
             [alertController addAction:okAction];
             [self presentViewController:alertController animated:YES completion:nil];
         }
     }];
}

- (void)buttonNextStep
{
    __weak SLPasswordBackController *weakSelf = self;
    [SMSSDK commitVerificationCode:self.textFieldVerify.text phoneNumber:self.textFieldPhone.text zone:@"86" result:^(NSError *error)
     {
         if (!error)
         {
             //验证成功后的回调
             //NSLog(@"这是正确的验证码，可以将密码给他");
             [weakSelf getUserInfoFromServer];
         }
         else
         {
             //验证失败后的回调
             UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码错误" preferredStyle:UIAlertControllerStyleAlert];
             UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"啊！" style:UIAlertActionStyleDefault handler:nil];
             [alertController addAction:okAction];
             [self presentViewController:alertController animated:YES completion:nil];
         }
     }];
}

- (void)getUserInfoFromServer
{
    _responseData = [[NSMutableData alloc] init];
    
    NSString *strURL = [NSString stringWithFormat:@"http://www.austrator.com/xbwu/queryX.php?phone=%@",_textFieldPhone.text];
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}


#pragma mark -- _timer定时器事件
- (void)timerBegan
{
    [buttonSendSMS setTitle:[NSString stringWithFormat:@"(%d)后可重新获取",numberTimeLeft] forState:UIControlStateNormal];
    if (numberTimeLeft == 1 || numberTimeLeft < 1)
    {
        [_timer invalidate];
        [buttonSendSMS setTitle:@"获取验证码" forState:UIControlStateNormal];
        buttonSendSMS.backgroundColor = [UIColor colorWithRed:78/255.0 green:198/255.0 blue:56/255.0 alpha:1];
        buttonSendSMS.enabled = YES;
    }
    numberTimeLeft = numberTimeLeft - 1;
}


#pragma mark -- UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark -- NSURLSession data delegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    //在该方法中可以得到响应信息，即response
    //NSLog(@"did ReceiveResponse -- %@",[NSThread currentThread]);
    
    //注意：需要使用compleionhandler 回调告诉系统应该如何处理服务器返回的数据，默认是取消的
    /*
     NSURLSessionResponseCancel = 0,        默认的处理方式，取消
     NSURLSessionResponseAllow = 1,         接收服务器返回的数据
     NSURLSessionResponseBecomeDownload = 2,变成一个下载请求
     NSURLSessionResponseBecomeStream        变成一个流
     */
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    //接收到服务器返回数据的时候会调用该方法，如果数据较大那么该方法可能会调用多次
    //NSLog(@"didReceiveData -- %@",[NSThread currentThread]);
    
    //接收服务器返回的数据
    [self.responseData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    //当请求完成的时候会调用该方法，如果请求失败，则error有值
    //NSLog(@"didCompleteWithError -- %@",[NSThread currentThread]);
    
    if (error == nil)
    {
        //解析JSON 数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:nil];
        NSString *password = [dic objectForKey:@"password"];
        NSString *strAlert = [NSString stringWithFormat:@"这是您的密码，请记住！  %@",password];
        NSLog(@"password = %@",password);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"找回密码成功" message:strAlert preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"找回密码失败" message:@"可能是手机网络有问题" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"不好" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}



@end
