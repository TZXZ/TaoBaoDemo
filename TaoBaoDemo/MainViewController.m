//
//  MainViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/1/22.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "MainViewController.h"
#import "SLHomeTableViewCell.h"

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height
#define NUM 5                                   //滚动广告的图片数量

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    self.numberNewsPage = 0;
    
    
    //初始化顶部的toolBar
    UIToolbar *myToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, WL, 44)];
    //初始化左边的扫一扫按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton setImage:[UIImage imageNamed:@"saoyisao.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 30, 40, 20)];
    leftLabel.text = @"扫一扫";
    [leftLabel setTextAlignment:NSTextAlignmentCenter];
    leftLabel.font = [UIFont systemFontOfSize:9.0];
    //初始化右边的消息按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [rightButton setImage:[UIImage imageNamed:@"xiaoxi.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(WL - 48, 30, 40, 20)];
    rightLabel.text = @"消息";
    [rightLabel setTextAlignment:NSTextAlignmentCenter];
    rightLabel.font = [UIFont systemFontOfSize:9.0];
    //创建一个toolBar 弹簧
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //设置toolBar 按钮
    [myToolBar addSubview:leftLabel];                  //向顶部的toolBar添加“扫一扫”label
    [myToolBar addSubview:rightLabel];                 //向顶部的toolBar添加“消息”label
    myToolBar.items = @[leftButtonItem,flexibleSpace,rightButtonItem];          //顶部toolBar的布局
    [self.view addSubview:myToolBar];                              //在self.view 中添加toolBar
    
    //初始化tableView （首页核心视图）
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WL, HL - 64 - 49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];                          //向self.view 中添加self.tableView
    //初始化tableView 的表头视图 (self.viewForTableHeadView)
    self.viewForTableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WL, WL * 0.3 + 150 + 60)];
    self.tableView.tableHeaderView = self.viewForTableHeadView;          //将自定义的tableHeadView 赋给真正的tableHeadView
    
    //初始化滚动广告
    self.whView = [[WHScrollAndPageView alloc] initWithFrame:CGRectMake(0, 0, WL, WL * 0.3)];
    NSMutableArray *mutableArrayImage = [NSMutableArray array];
    for (int i = 0; i < NUM; i ++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"RollImage_%d.jpg",i]];
        [mutableArrayImage addObject:imageView];
    }
    [self.whView setImageViewAry:mutableArrayImage];
    //[self.scrollView addSubview:self.whView];
    [self.whView shouldAutoShow:YES];
    self.whView.delegate = self;
    [self.viewForTableHeadView addSubview:self.whView];             //将滚动广告视图添加到self.viewForTableHeadView
    
    //利用双重循环创建10个Button
    int spaceLength = (WL - 200) / 6;
    NSArray *arrayLabelName = @[@"天猫",@"聚划算",@"天猫国际",@"口碑外卖",@"天猫超市",@"充值中心",@"阿里旅行",@"领金币",@"淘生活",@"分类"];
    int tempY = WL * 0.3 + 10;
    int tempX = spaceLength;
    int tempNumber = 30;
    for (int i = 0; i < 2; i ++)
    {
        for (int j = 0; j < 5; j ++)
        {
            tempNumber = tempNumber + 1;
            //添加button
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(tempX + (j * (spaceLength + 40)), tempY + (i * 70), 40, 40)];
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"button%d_image.png",tempNumber]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(tenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setTag:tempNumber];
            [self.viewForTableHeadView addSubview:button];
            //添加button下面的label
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(tempX + (j * (spaceLength + 40)), WL * 0.3 + 50 + (i * 70), 40, 20)];
            int row = tempNumber - 31;
            label.text = [arrayLabelName objectAtIndex:row];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setFont:[UIFont systemFontOfSize:9.0]];
            [self.viewForTableHeadView addSubview:label];                    //将10个button 添加到self.viewForTableViewHead
        }
    }
    
    //初始化淘宝头条新闻滚动视图（self.viewForRotatingNews）、线条、右边的imageView
    self.viewForRotatingNews = [[UIView alloc] initWithFrame:CGRectMake(0, WL * 0.3 + 150, WL, 60)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 40, 20)];
    imageView.image = [UIImage imageNamed:@"taobao_toutiao.png"];
    [self.viewForRotatingNews addSubview:imageView];                  //添加头条到新闻滚动视图上面去
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(10, 0, WL - 20, 1)];
    topLine.backgroundColor = [UIColor grayColor];
    [self.viewForRotatingNews addSubview:topLine];                   //添加顶部线条到新闻滚动视图
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(99, 15, 1, 30)];
    rightLine.backgroundColor = [UIColor grayColor];
    //[self.viewForRotatingNews addSubview:rightLine];                 //添加右边线条到新闻滚动视图里面去
    self.imageViewNews = [[UIImageView alloc] initWithFrame:CGRectMake(120, 5, WL - 100 - 20 - 20, 50)];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(startRotatingNews) userInfo:nil repeats:YES];
    self.imageViewNews.image = [UIImage imageNamed:@"rotating_news_0.png"];
    [self.viewForRotatingNews addSubview:self.imageViewNews];                 //将右边的imageView 添加到新闻滚动视图上面去
    [self.viewForTableHeadView addSubview:self.viewForRotatingNews];          //将新闻滚动视图添加到表头视图上面去
    
}


#pragma mark -- system相关事件
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//界面消失的时候，停止滚动
- (void)viewDidDisappear:(BOOL)animated
{
    [self.whView shouldAutoShow:NO];
}

//界面出现的时候，继续滚动
- (void)viewDidAppear:(BOOL)animated
{
    [self.whView shouldAutoShow:YES];
}

#pragma mark -- 10个按钮的组合事件
- (void)tenButtonAction:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 31:
            NSLog(@"天猫");
            break;
            
        case 32:
            NSLog(@"聚划算");
            break;
            
        case 33:
            NSLog(@"天猫国际");
            break;
            
        case 34:
            NSLog(@"口碑外卖");
            break;
            
        case 35:
            NSLog(@"天猫超市");
            break;
            
        case 36:
            NSLog(@"充值中心");
            break;
            
        case 37:
            NSLog(@"阿里旅行");
            break;
            
        case 38:
            NSLog(@"领金币");
            break;
            
        case 39:
            NSLog(@"淘生活");
            break;
            
        case 40:
            NSLog(@"分类");
            break;
            
            
        default:
            break;
    }
}


#pragma mark -- 开始新闻滚动事件 startRotatingNews
- (void)startRotatingNews
{
    self.numberNewsPage += 1;
    if (self.numberNewsPage == 3)
    {
        self.numberNewsPage = 0;
    }
    
    CATransition *animation = [CATransition animation];
    animation.type = @"cube";
    animation.subtype = kCATransitionFromTop;
    [self.imageViewNews.layer addAnimation:animation forKey:@"animation"];
    self.imageViewNews.image = [UIImage imageNamed:[NSString stringWithFormat:@"rotating_news_%d.png",self.numberNewsPage]];
}


#pragma mark -- TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *cellID = @"SectionZero";
        SLHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil)
        {
            cell = [SLHomeTableViewCell alloc];
            cell.widthLength = WL;
            cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.label1_2.textColor = [UIColor redColor];
        cell.label2_2.textColor = [UIColor redColor];
        cell.label3_2.textColor = [UIColor redColor];
        cell.label4_2.textColor = [UIColor redColor];
        cell.label5_2.textColor = [UIColor redColor];
        cell.label6_2.textColor = [UIColor redColor];
        cell.label7_2.textColor = [UIColor redColor];
        cell.label8_2.textColor = [UIColor redColor];
        
        return cell;
    }
    else if (indexPath.section == 2)
    {
        static NSString *cellID = @"SectionTwo";
        SLHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil)
        {
            cell = [SLHomeTableViewCell alloc];
            cell.widthLength = WL;
            cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.label1_1.text = @"全球购";
        cell.label1_2.text = @"搜索全球美好生活";
        cell.label2_1.text = @"中国质造";
        cell.label2_2.text = @"品质中国造";
        cell.label3_1.text = @"特色中国";
        cell.label3_2.text = @"地道才够味";
        cell.label4_1.text = @"极有家";
        cell.label4_2.text = @"严格选好货";
        cell.label5_1.text = @"拍卖会";
        cell.label5_2.text = @"特价车返场";
        cell.label6_1.text = @"医药健康";
        cell.label6_2.text = @"几份兑好礼";
        cell.label7_1.text = @"淘宝众筹";
        cell.label7_2.text = @"激光扫地机";
        cell.label8_1.text = @"每日新品";
        cell.label8_2.text = @"找新品戳我";
        cell.imageViewHead.image = [UIImage imageNamed:@"good_goods.png"];
        cell.labelHead.text = @"特色好货";
        cell.labelHead.textColor = [UIColor colorWithRed:65/255.0 green:119/255.0 blue:255/255.0 alpha:1];
        
        return cell;
    }
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"This is good !";
    
    
    return cell;
}

#pragma mark -- TableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210.0;
}




@end
