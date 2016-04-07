//
//  UserViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/1/22.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "UserViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DetaiViewController.h"

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height

@interface UserViewController ()

@end

@implementation UserViewController
{
    AppDelegate *delegate;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的淘宝";
    self.view.frame = [[UIScreen mainScreen] bounds];      //自适应尺寸必备代码
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;        //不要让self
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WL, HL - 64 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];    //添加表视图
    
    //初始化一个view视图，作为表视图的头视图
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WL, 260)];
    headView.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WL, 260)];
    //imageView.image = [UIImage imageNamed:@"windows8.jpg"];
    [headView addSubview:imageView];    //添加背景图片
    int marginL = WL / 2;
    self.imageViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(marginL - 60, 40, 120, 120)];
    self.imageViewHead.layer.cornerRadius = 60;
    self.imageViewHead.layer.masksToBounds = YES;
    self.imageViewHead.image = [UIImage imageNamed:@"user_head.png"];
    [headView addSubview:self.imageViewHead];   //添加用户头像
    self.labelUserName = [[UILabel alloc] initWithFrame:CGRectMake(marginL - 60, 180, 120, 25)];
    [self.labelUserName setTextAlignment:NSTextAlignmentCenter];
    self.labelUserName.text = @"点击登录";
    [self.labelUserName setFont:[UIFont systemFontOfSize:17.0]];
    [headView addSubview:self.labelUserName];     //添加用户姓名
    UITapGestureRecognizer *tapRecognize = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewTapAction)];
    tapRecognize.numberOfTapsRequired = 1;
    [headView addGestureRecognizer:tapRecognize];
    self.tableView.tableHeaderView = headView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if (delegate.userHasLogin)
    {
        self.labelUserName.text = delegate.userInfomation.name;
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *imageName = [NSString stringWithFormat:@"%@.png",delegate.userInfomation.phone];
        NSString *filePath = [documentPath stringByAppendingPathComponent:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (delegate.userInfomation.imageName != nil || [fileManager fileExistsAtPath:filePath])
        {
            self.imageViewHead.image = [UIImage imageWithContentsOfFile:filePath];
        }
        
    }else
    {
        [super viewWillAppear:animated];
        self.labelUserName.text = @"点击登录";
        self.imageViewHead.image = [UIImage imageNamed:@"user_head.png"];
    }
}


#pragma mark -- 用户登录响应事件
- (void)headViewTapAction
{
    //NSLog(@"点击了登录!");
    if (delegate.userHasLogin)
    {
        //NSLog(@"用户已经在登录状态了!");
        DetaiViewController *detailViewController = [[DetaiViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
        [self presentViewController:navController animated:YES completion:nil];
    }
    else
    {
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        [loginViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
        [self presentViewController:navController animated:YES completion:nil];
    }
    
}


#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 1;
            break;
            
        case 1:
            return 1;
            break;
            
        case 2:
            return 5;
            break;
            
        default:
            return 10;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellID = [NSString stringWithFormat:@"CellId_%d",(int)indexPath.row];  //BUG解决
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14.0]];
    
    switch (indexPath.section)
    {
        case 0:
            cell.accessoryType = UITableViewCellAccessoryNone;
            return cell;     //这个cell是炮灰，并没有什么用
            break;
            
        case 1:
            cell.textLabel.text = @"我的订单";
            cell.detailTextLabel.text = @"查看全部订单";
            cell.imageView.image = [UIImage imageNamed:@"all_order.png"];
            return cell;
            break;
            
        case 2:
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"待付款";
                    cell.imageView.image = [UIImage imageNamed:@"wait_pay"];
                    cell.detailTextLabel.text = @"瞅瞅看还差多少钱";
                    break;
                    
                case 1:
                    cell.textLabel.text = @"待发货";
                    cell.imageView.image = [UIImage imageNamed:@"wait_dispatch.png"];
                    cell.detailTextLabel.text = @"等还是不等真是个问题";
                    break;
                    
                case 2:
                    cell.textLabel.text = @"待收货";
                    cell.imageView.image = [UIImage imageNamed:@"wait_carray.png"];
                    cell.detailTextLabel.text = @"赶紧去拿好东西";
                    break;
                    
                case 3:
                    cell.textLabel.text = @"待评价";
                    cell.imageView.image = [UIImage imageNamed:@"wait_judge.png"];
                    cell.detailTextLabel.text = @"给个好评吧亲";
                    break;
                    
                case 4:
                    cell.textLabel.text = @"退款/售后";
                    cell.imageView.image = [UIImage imageNamed:@"after_services.png"];
                    cell.detailTextLabel.text = @"有什么问题找我";
                    break;
                    
                default:
                    cell.textLabel.text = @"This is section 2";
                    break;
            }
            return cell;
            break;
            
        case 3:
            switch (indexPath.row)
            {
                case 0:
                    cell.textLabel.text = @"店铺收藏";
                    cell.imageView.image = [UIImage imageNamed:@"shop_collect.png"];
                    break;
                    
                case 1:
                    cell.textLabel.text = @"足迹";
                    cell.imageView.image = [UIImage imageNamed:@"foot_print.png"];
                    break;
                    
                case 2:
                    cell.textLabel.text = @"卡券包";
                    cell.imageView.image = [UIImage imageNamed:@"discount_coupon.png"];
                    break;
                    
                case 3:
                    cell.textLabel.text = @"蚂蚁花呗";
                    cell.imageView.image = [UIImage imageNamed:@"ant_lend.png"];
                    break;
                    
                case 4:
                    cell.textLabel.text = @"会员中心";
                    cell.imageView.image = [UIImage imageNamed:@"vip_center.png"];
                    break;
                    
                case 5:
                    cell.textLabel.text = @"我要开店";
                    cell.imageView.image = [UIImage imageNamed:@"open_shop.png"];
                    break;
                    
                case 6:
                    cell.textLabel.text = @"我的评价";
                    cell.imageView.image = [UIImage imageNamed:@"my_judge.png"];
                    break;
                    
                case 7:
                    cell.textLabel.text = @"我的问答";
                    cell.imageView.image = [UIImage imageNamed:@"my_anwser.png"];
                    break;
                    
                case 8:
                    cell.textLabel.text = @"我的分享";
                    cell.imageView.image = [UIImage imageNamed:@"my_share.png"];
                    break;
                    
                case 9:
                    cell.textLabel.text = @"我的小蜜";
                    cell.imageView.image = [UIImage imageNamed:@"my_secretary.png"];
                    break;
                    
                default:
                    break;
            }
            return cell;
            break;
            
        default:
            return cell;
            break;
    }
}


#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 0.01;    //变相隐藏tableView 的第一个section
    }else
    {
        return  44.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (delegate.userHasLogin)
    {
        switch (indexPath.section)
        {
            case 0:
                NSLog(@"你不可能点到这个section 的！");
                break;
                
            case 1:
                NSLog(@"我的订单");
                break;
                
            case 2:
                switch (indexPath.row)
            {
                case 0:
                    NSLog(@"待付款");
                    break;
                    
                case 1:
                    NSLog(@"待发货");
                    break;
                    
                case 2:
                    NSLog(@"待收货");
                    break;
                    
                case 3:
                    NSLog(@"待评价");
                    break;
                    
                case 4:
                    NSLog(@"退款/售后");
                    break;
                    
                default:
                    break;
            }
                break;
                
            case 3:
                switch (indexPath.row)
            {
                case 0:
                    NSLog(@"店铺收藏");
                    break;
                    
                case 1:
                    NSLog(@"足迹");
                    break;
                    
                case 2:
                    NSLog(@"卡券包");
                    break;
                    
                case 3:
                    NSLog(@"蚂蚁花呗");
                    break;
                    
                case 4:
                    NSLog(@"会员中心");
                    break;
                    
                case 5:
                    NSLog(@"我要开店");
                    break;
                    
                case 6:
                    NSLog(@"我的评价");
                    break;
                    
                case 7:
                    NSLog(@"我的问答");
                    break;
                    
                case 8:
                    NSLog(@"我的分享");
                    break;
                    
                case 9:
                    NSLog(@"我的小蜜");
                    break;
                    
                default:
                    break;
            }
                break;
                
            default:
                break;
        }

    }
    else           //判断用户没有登录的情况下
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户未登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"待会再登录" style:0 handler:nil];
        UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"马上去登录" style:0 handler:^(UIAlertAction * _Nonnull action)
        {
            LoginViewController *loginViewController = [[LoginViewController alloc] init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
            [self presentViewController:navController animated:YES completion:nil];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:loginAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.0;
    }else
    {
        return 10.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0;
}





@end
