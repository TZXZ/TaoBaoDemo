//
//  RegisterViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/19.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "RegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>
//#import "ASIFormDataRequest.h"
//#import "ASIHTTPRequest.h"

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"免费注册";
    self.view.frame = [[UIScreen mainScreen] bounds];
    
//新建手机号、验证码、两次密码输入框和获取验证码按钮
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
    
    //初始化姓名文本框、两个密码文本框和注册按钮
    self.textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(tempL - 150, 220, 300, 40)];
    self.textFieldName.placeholder = @"请输入昵称";
    self.textFieldName.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageViewName = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageViewName.image = [UIImage imageNamed:@"name_image.png"];
    self.textFieldName.leftView = imageViewName;
    UIView *lineX = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 300, 1)];
    lineX.backgroundColor = [UIColor grayColor];
    [self.textFieldName addSubview:lineX];
    self.textFieldName.hidden = YES;
    self.textFieldName.delegate = self;
    [self.view addSubview:self.textFieldName];              //添加用户姓名文本框
    
    self.textFieldPassword1 = [[UITextField alloc] initWithFrame:CGRectMake(tempL - 150, 220, 300, 40)];
    self.textFieldPassword1.placeholder = @"请输入您的密码(至少6位)";
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 300, 1)];
    line3.backgroundColor = [UIColor grayColor];
    [self.textFieldPassword1 addSubview:line3];
    self.textFieldPassword1.hidden = YES;
    self.textFieldPassword1.secureTextEntry = YES;
    self.textFieldPassword1.delegate = self;
    self.textFieldPassword1.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageViewPassword1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageViewPassword1.image = [UIImage imageNamed:@"password_image.png"];
    self.textFieldPassword1.leftView = imageViewPassword1;
    [self.view addSubview:self.textFieldPassword1];             //添加第一个密码文本框
    
    self.textFieldPassword2 = [[UITextField alloc] initWithFrame:CGRectMake(tempL - 150, 220, 300, 40)];
    self.textFieldPassword2.placeholder = @"请再次输入您的密码";
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 300, 1)];
    line4.backgroundColor = [UIColor grayColor];
    [self.textFieldPassword2 addSubview:line4];
    self.textFieldPassword2.hidden = YES;
    self.textFieldPassword2.secureTextEntry = YES;
    self.textFieldPassword2.delegate = self;
    self.textFieldPassword2.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageViewPassoword2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageViewPassoword2.image = [UIImage imageNamed:@"password_image.png"];
    self.textFieldPassword2.leftView = imageViewPassoword2;
    [self.view addSubview:self.textFieldPassword2];             //添加第二个密码文本框
    
    buttonRegister = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, WL - 40, 40)];
    buttonRegister.backgroundColor = [UIColor colorWithRed:78/255.0 green:198/255.0 blue:56/255.0 alpha:1];
    buttonRegister.hidden = YES;
    buttonRegister.layer.cornerRadius = 6.0f;
    buttonRegister.layer.masksToBounds = YES;
    [buttonRegister setTitle:@"注册" forState:UIControlStateNormal];
    [buttonRegister addTarget:self action:@selector(buttonRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonRegister];           //添加注册按钮
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark -- button相关事件
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
    [SMSSDK commitVerificationCode:self.textFieldVerify.text phoneNumber:self.textFieldPhone.text zone:@"86" result:^(NSError *error)
    {
        if (!error)
        {
            //验证成功后的回调
            [self.view endEditing:YES];
            [UIView animateWithDuration:3 animations:^
            {
                buttonNextStep.frame = CGRectMake(20, 400, WL - 40, 40);
            } completion:^(BOOL finished)
            {
                buttonRegister.hidden = NO;
                self.textFieldPassword2.hidden = NO;
                [UIView animateWithDuration:1 animations:^
                {
                    self.textFieldPassword2.frame = CGRectMake(WL / 2 - 150, 340, 300, 40);
                } completion:^(BOOL finished)
                {
                    self.textFieldPassword1.hidden = NO;
                    [UIView animateWithDuration:1 animations:^
                    {
                        self.textFieldPassword1.frame = CGRectMake(WL / 2 - 150, 280, 300, 40);
                    } completion:^(BOOL finished)
                    {
                        self.textFieldName.hidden = NO;
                    }];
                }];
            }];
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

- (void)buttonRegister
{
    [self.view endEditing:YES];
    self.responseData = [[NSMutableData alloc] init];
    
    if (self.textFieldPassword1.text.length >= 6 && [self.textFieldPassword2.text isEqualToString:self.textFieldPassword1.text] && self.textFieldName.text.length != 0)
    {
        //NSLog(@"用户注册信息合法");
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(WL / 2 - 30, HL / 2, 60, 40)];
//        label.text = @"正在注册";
//        [self.view addSubview:label];         //添加正在注册提示label
        
        NSString *strURL = [NSString stringWithFormat:@"http://www.austrator.com/xbwu/insertX.php?phone=%@&name=%@&password=%@",self.textFieldPhone.text,self.textFieldName.text,self.textFieldPassword1.text];
        strURL = [strURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:strURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        //开始网络请求
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
        [dataTask resume];
        
    }else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册信息不合法！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"啊！" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0, -100, WL, HL);
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectMake(0, 0, WL, HL);
    [UIView commitAnimations];
}


#pragma mark -- NSURLSession data delegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    //当请求完成的时候会调用该方法，如果请求失败，则error有值
    if (error == nil)
    {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:nil];
        if ([[array lastObject] boolValue])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户注册成功,点击确定3秒后返回上一界面" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
               {
                   sleep(3);
                   [self.navigationController popViewControllerAnimated:YES];
               }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户之前已经注册过，无须再次注册，点击确定后3秒返回上一界面" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                {
                    sleep(3);
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册失败" message:@"可能是手机网络有问题或者服务器繁忙" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"不好" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}




@end
