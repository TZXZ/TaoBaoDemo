//
//  SLNameChangeController.m
//  TaoBaoDemo
//
//  Created by fang on 16/4/7.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLNameChangeController.h"
#import "AppDelegate.h"
#import "UserInfomation.h"

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height

@interface SLNameChangeController ()

@end


@implementation SLNameChangeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.title = @"更改姓名";
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //初始化姓名控件
    //int tempL = WL / 2;
    _textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(20, 100 + 30, WL - 40, 40)];
    _textFieldName.placeholder = @"请输入您的新用户名";
    _textFieldName.delegate = self;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, WL - 40, 1)];
    line.backgroundColor = [UIColor grayColor];
    [_textFieldName addSubview:line];
    [_textFieldName addTarget:self action:@selector(textFieldNameChanging:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_textFieldName];
    
    //初始化下一步按钮
    _buttonNextStep = [[UIButton alloc] initWithFrame:CGRectMake(20, 220, WL - 40, 40)];
    _buttonNextStep.backgroundColor = [UIColor colorWithRed:78/255.0 green:198/255.0 blue:56/255.0 alpha:1];
    _buttonNextStep.enabled = NO;
    _buttonNextStep.layer.cornerRadius = 6;
    _buttonNextStep.layer.masksToBounds = YES;
    _buttonNextStep.showsTouchWhenHighlighted = YES;
    [_buttonNextStep addTarget:self action:@selector(buttonNextStep:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonNextStep setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:_buttonNextStep];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- Action I
- (void)textFieldNameChanging:(UITextField *)textField
{
    //NSLog(@"我值改变了！");
    if (textField.text.length == 0)
    {
        _buttonNextStep.enabled = NO;
    }
    else
    {
        _buttonNextStep.enabled = YES;
    }
}

- (void)buttonNextStep:(UIButton *)sender
{
    //NSLog(@"下一步准备好");
    [self.view endEditing:YES];
    __weak NSString *strName = _textFieldName.text;
    NSString *strURL = [NSString stringWithFormat:@"http://42.96.178.214/php/updatename.php?name=%@&phone=%@",_textFieldName.text,[delegate.userInfomation phone]];
    strURL = [strURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (!error)
        {
            //NSLog(@"请求成功");
            UserInfomation *temp = delegate.userInfomation;
            temp.name = strName;
            delegate.userInfomation = temp;
            
            dispatch_async(dispatch_get_main_queue(), ^
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"用户姓名更改成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            });

        }
        else
        {
             //NSLog(@"请求失败");
            dispatch_async(dispatch_get_main_queue(), ^
            {
               
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"由于网路以及其他原因，用户姓名更改失败，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            });

        }
    }];
    
    [dataTask resume];
}


#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
