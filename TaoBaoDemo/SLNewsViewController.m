//
//  SLNewsViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/4/5.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLNewsViewController.h"

@interface SLNewsViewController ()

@end

@implementation SLNewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加返回按钮
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(viewBackAction)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.title = @"淘宝头条";
    
    //添加上页按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"上页" style:UIBarButtonItemStylePlain target:self action:@selector(backToLast)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    NSString *strURL = @"https://h5.m.taobao.com/headlines/hlHomepage.html?locate=Headline-2&spm=a215s.7406091.1.Headline-2&feed_ids=300870%2C300757%2C212387%2C301276%2C299828%2C299263&scm=2027.1.2.189&from=1";
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewBackAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backToLast
{
    NSString *strURL = @"https://h5.m.taobao.com/headlines/hlHomepage.html?locate=Headline-2&spm=a215s.7406091.1.Headline-2&feed_ids=300870%2C300757%2C212387%2C301276%2C299828%2C299263&scm=2027.1.2.189&from=1";
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


@end
