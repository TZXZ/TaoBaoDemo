//
//  LoginViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/18.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "LoginViewController.h"
#import "CateAnimationLogin.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "SLPasswordBackController.h"

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height

@interface LoginViewController ()


@end

@implementation LoginViewController
{
    CateAnimationLogin *loginView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];     //必备代码之一
    self.title = @"用户登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(waitingForYou) name:UITextFieldTextDidChangeNotification object:nil];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
//添加导航控制器上面的左侧返回button
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:@"view_back.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(viewBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
//添加用户名和密码模块
    loginView = [[CateAnimationLogin alloc] initWithFrame:CGRectMake(0, 0, WL, 400)];
    [self.view addSubview:loginView];
    
//添加登录按钮以及注册按钮和找回密码按钮、第三方登录按纽
    self.buttonLogin = [[UIButton alloc] initWithFrame:CGRectMake(20, 400, WL - 40, 40)];
    [self.buttonLogin setBackgroundImage:[UIImage imageNamed:@"login_button.png"] forState:UIControlStateNormal];
    self.buttonLogin.enabled = NO;
    self.buttonLogin.layer.cornerRadius = 6;
    self.buttonLogin.layer.masksToBounds = YES;
    [self.buttonLogin setTitle:@"登录" forState:UIControlStateNormal];
    [self.buttonLogin addTarget:self action:@selector(buttonLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonLogin];    //添加登录按钮
    
    UIButton *buttonForPasswordBack = [[UIButton alloc] initWithFrame:CGRectMake( WL - 100, HL - 125, 70, 30)];
    [buttonForPasswordBack setTitle:@"找回密码" forState:UIControlStateNormal];
    [buttonForPasswordBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonForPasswordBack.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    buttonForPasswordBack.showsTouchWhenHighlighted = YES;
    [buttonForPasswordBack addTarget:self action:@selector(buttonForPasswordBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonForPasswordBack];      //添加找回密码按钮
    
    int tempLength = WL / 2;
    UIButton *buttonRegister = [[UIButton alloc] initWithFrame:CGRectMake(tempLength - 50, HL - 90, 100, 30)];
    [buttonRegister setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonRegister.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    buttonRegister.showsTouchWhenHighlighted = YES;
    [buttonRegister addTarget:self action:@selector(buttonRegisterAction) forControlEvents:UIControlEventTouchUpInside];
    buttonRegister.layer.masksToBounds = YES;
    buttonRegister.layer.cornerRadius = 8.0;
    buttonRegister.layer.borderWidth = 1.0;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorRef = CGColorCreate(colorSpace, (CGFloat[]){1, 0, 0, 1});
    buttonRegister.layer.borderColor = colorRef;
    [buttonRegister setTitle:@"免费注册" forState:UIControlStateNormal];
    [self.view addSubview:buttonRegister];                //添加免费注册按钮
    
    UILabel *lableAttention = [[UILabel alloc] initWithFrame:CGRectMake(WL - 250, HL - 30, 100, 30)];
    lableAttention.text = @"其他账号登录";
    [lableAttention setFont:[UIFont systemFontOfSize:14.0]];
    //[self.view addSubview:lableAttention];              //添加第三方合作账号登录提示
    
    UIButton *buttonForTencent = [[UIButton alloc] initWithFrame:CGRectMake(WL - 45, HL - 30, 30, 30)];
    [buttonForTencent setImage:[UIImage imageNamed:@"login_Tencent.png"] forState:UIControlStateNormal];
    [buttonForTencent addTarget:self action:@selector(buttonForTencent) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:buttonForTencent];       //添加Tencent登录
    
    UIButton *buttonForWeChat = [[UIButton alloc] initWithFrame:CGRectMake(WL - 90, HL - 30, 30, 30)];
    [buttonForWeChat setImage:[UIImage imageNamed:@"we_chat.png"] forState:UIControlStateNormal];
    [buttonForWeChat addTarget:self action:@selector(buttonForWeChat) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:buttonForWeChat];        //添加微信登录
    
    UIButton *buttonForWeibo = [[UIButton alloc] initWithFrame:CGRectMake(WL - 134, HL - 30, 30, 30)];
    [buttonForWeibo setImage:[UIImage imageNamed:@"wei_bo.png"] forState:UIControlStateNormal];
    [buttonForWeibo addTarget:self action:@selector(buttonForWeibo) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:buttonForWeibo];         //添加微博登录
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)waitingForYou
{
    if (loginView.userNameTextField.text.length != 0 && loginView.PassWordTextField.text.length != 0)
    {
        self.buttonLogin.enabled = YES;
    }else
    {
        self.buttonLogin.enabled = NO;
    }
}


#pragma mark -- 登录、找回密码、注册、第三方登录按钮事件集合
- (void)buttonLoginAction:(UIButton *)sender      //登录按钮
{
    NSLog(@"用户点击了登录 !");
    self.responseData = [[NSMutableData alloc] init];
    
    NSString *strURL = [NSString stringWithFormat:@"http://www.austrator.com/xbwu/queryX.php?phone=%@",loginView.userNameTextField.text];
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}

- (void)buttonForPasswordBackAction
{
    //NSLog(@"用户点击了找回密码");
    SLPasswordBackController *passwordController = [[SLPasswordBackController alloc] init];
    [self.navigationController pushViewController:passwordController animated:YES];
}

- (void)buttonRegisterAction            //注册按钮
{
    //NSLog(@"用户点击了免费注册按钮");
    RegisterViewController *reViewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:reViewController animated:YES];
}

//第三方登录  QQ  微信  微博
- (void)buttonForTencent
{
    NSLog(@"用户点击了腾讯登录");
}

- (void)buttonForWeChat
{
    NSLog(@"用户点击了微信登录");
}

- (void)buttonForWeibo
{
    NSLog(@"用户点击了微博登录");
}


#pragma mark -- viewBackAction   返回上一级视图
- (void)viewBackAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
        //解析JSON 数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingMutableContainers error:&error];
        NSString *password = [dic objectForKey:@"password"];
        if ([password isEqualToString:loginView.PassWordTextField.text])
        {
            //NSLog(@"登录成功! password = %@",password);
            appDelegate.userInfomation.phone = [dic objectForKey:@"phone"];
            appDelegate.userInfomation.name = [dic objectForKey:@"name"];
            appDelegate.userInfomation.password = [dic objectForKey:@"password"];
            appDelegate.userInfomation.sex = [dic objectForKey:@"sex"];
            appDelegate.userInfomation.birthday = [dic objectForKey:@"birthday"];
            appDelegate.userInfomation.address1 = [dic objectForKey:@"address1"];
            appDelegate.userInfomation.address2 = [dic objectForKey:@"address2"];
            appDelegate.userInfomation.address3 = [dic objectForKey:@"address3"];
            appDelegate.userInfomation.address4 = [dic objectForKey:@"address4"];
            appDelegate.userInfomation.address5 = [dic objectForKey:@"address5"];
            appDelegate.userHasLogin = YES;
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已登录成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *viewBackAction = [UIAlertAction actionWithTitle:@"点击返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                             {
                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                             }];
            [alertController addAction:viewBackAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"用户名或者密码错误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:0 handler:nil];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"可能是手机网络有问题或者服务器繁忙" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"不好" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}



@end
