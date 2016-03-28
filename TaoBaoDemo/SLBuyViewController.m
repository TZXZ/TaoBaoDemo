//
//  SLBuyViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/27.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLBuyViewController.h"
#import "SLBuyCustomHeadView.h"

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height

@interface SLBuyViewController ()

@end

@implementation SLBuyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];
    NSLog(@"let me see !");
    
//初始化table view,其他的视图都是放在这个上面的
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, WL, HL - 20 - 49)];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
//初始化表头视图
    viewForTableHead = [[SLBuyCustomHeadView alloc] initWithFrame:CGRectMake(0, 0, WL, WL * 0.8 + 80 + 40)];
    self.tableView.tableHeaderView = viewForTableHead;                   //将自定义的视图赋给table head view
    
    
//初始化底部加入购物车按钮以及立即购买按钮
    [self loadBottomView];
    
    
//初始化返回按钮
    UIButton *buttonViewBack = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];
    [buttonViewBack setImage:[UIImage imageNamed:@"buy_view_back.png"] forState:UIControlStateNormal];
    [buttonViewBack addTarget:self action:@selector(viewBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonViewBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- viewDidLoad 里面的一些初始化的方法
- (void)loadBottomView
{
    UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(0, HL - 49 - 0.5, WL, 0.5)];
    line0.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:line0];                     //添加线条划清界限
    
    UIButton *buttonService = [[UIButton alloc] initWithFrame:CGRectMake(0, HL - 49, 49, 49)];
    //[buttonService setImage:[UIImage imageNamed:@"customer_service.png"] forState:UIControlStateNormal];
    [self.view addSubview:buttonService];            //添加客服按钮
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(49 - 0.5, HL - 49, 0.5, 49)];
    line1.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:line1];                  //添加右边线条
    
    UIButton *buttonStore = [[UIButton alloc] initWithFrame:CGRectMake(49, HL - 49, 49, 49)];
    //[buttonStore setImage:[UIImage imageNamed:@"store_image.png"] forState:UIControlStateNormal];
    [self.view addSubview:buttonStore];            //添加店铺按钮
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(49 + 49 - 0.5, HL - 49, 0.5, 49)];
    line2.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:line2];                 //添加右边线条
    
    UIButton *buttonCollect = [[UIButton alloc] initWithFrame:CGRectMake(49 + 49, HL - 49, 49, 49)];
    //[buttonCollect setImage:[UIImage imageNamed:@"collect_image.png"] forState:UIControlStateNormal];
    [self.view addSubview:buttonCollect];            //添加收藏按钮
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(49 + 49 + 49 - 0.5, HL - 49, 0.5, 49)];
    line3.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:line3];                 //添加右边线条
    
    float tempL = (WL - 49 - 49 - 49) / 2;
    UIButton *buttonAddCart = [[UIButton alloc] initWithFrame:CGRectMake(147, HL - 49, tempL, 49)];
    buttonAddCart.backgroundColor = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:26/255.0 alpha:1];
    [buttonAddCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    buttonAddCart.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:buttonAddCart];               //添加加入购物车按钮
}


#pragma mark -- TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"选择商品分类";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    
    return cell;
}


#pragma mark -- TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}





@end
