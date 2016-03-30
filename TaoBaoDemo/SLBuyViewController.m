//
//  SLBuyViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/27.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLBuyViewController.h"
#import "SLBuyCustomHeadView.h"
#import "SLBuyNumberView.h"
#import "AppDelegate.h"
#import "SLGoodsDetail.h"

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
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    goodsYouSeeNow = [[SLGoodsDetail alloc] init];
    
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
    
    
//初始化确定数量按钮
    viewForNumber = [[SLBuyNumberView alloc] initWithFrame:CGRectMake(0, HL, WL, 150)];
    [self.view addSubview:viewForNumber];
    
 
//向服务器询问是我们该加载什么商品
    [self getGoodsMessageFromServer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:1 animations:^
    {
        viewForNumber.frame = CGRectMake(0, HL, WL, 150);
    }];
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
    [buttonAddCart addTarget:self action:@selector(buttonAddCart:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonAddCart];               //添加加入购物车按钮
    
    UIButton *buttonBuyNow = [[UIButton alloc] initWithFrame:CGRectMake(147 + tempL, HL - 49, tempL, 49)];
    buttonBuyNow.backgroundColor = [UIColor redColor];
    [buttonBuyNow setTitle:@"立即购买" forState:UIControlStateNormal];
    buttonBuyNow.titleLabel.textColor = [UIColor whiteColor];
    [buttonBuyNow addTarget:self action:@selector(buttonBuyNow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBuyNow];               //添加加入购物车按钮
}

- (void)getGoodsMessageFromServer
{
    //1.确定请求路径
    //NSString *strURL = [NSString stringWithFormat:@"http://42.96.178.214/php/queryZ.php?number=%d",delegate.numberOfGoods];
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/queryZ.php?number=%d",delegate.numberOfGoods];
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
          {
              NSLog(@"当前线程为 %@",[NSThread currentThread]);
              if (!error)
              {
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                  NSLog(@"dic = %@",dic);
                  goodsYouSeeNow.name = [dic objectForKey:@"name"];
                  goodsYouSeeNow.number = [dic objectForKey:@"number"];
                  goodsYouSeeNow.price = [dic objectForKey:@"price"];
                  goodsYouSeeNow.imgAddress1 = [dic objectForKey:@"address1"];
                  goodsYouSeeNow.imgAddress2 = [dic objectForKey:@"address2"];
                  goodsYouSeeNow.imgAddress3 = [dic objectForKey:@"address3"];
                  goodsYouSeeNow.describe = [dic objectForKey:@"describe"];
                  goodsYouSeeNow.postState = [dic objectForKey:@"poststat"];
                  goodsYouSeeNow.saleState = [dic objectForKey:@"salestat"];
                  goodsYouSeeNow.addressState = [dic objectForKey:@"addressstat"];
                  
                  viewForTableHead.labelDetail.text = goodsYouSeeNow.describe;
                  viewForTableHead.labelMoneyLow.text = goodsYouSeeNow.price;
                  viewForTableHead.labelTest1.text = goodsYouSeeNow.postState;
                  viewForTableHead.labelTest2.text = goodsYouSeeNow.saleState;
                  viewForTableHead.labelTest3.text = goodsYouSeeNow.addressState;
                  
                  //获取第一张图片
                  NSString *strURL1 = [NSString stringWithFormat:@"http://42.96.178.214/img/%d/%@",delegate.numberOfGoods,goodsYouSeeNow.imgAddress1];
                  NSURL *url1 = [NSURL URLWithString:strURL1];
                  NSURLSession *session1 = [NSURLSession sharedSession];
                  NSURLSessionDataTask *dataTask1 = [session1 dataTaskWithURL:url1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                  {
                      viewForTableHead.imageView1.image = [UIImage imageWithData:data];
                      
                      NSLog(@"获取第一张图片成功！");
                  }];
                  [dataTask1 resume];
                  
                  //获取第二张图片
                  NSString *strURL2 = [NSString stringWithFormat:@"http://42.96.178.214/img/%d/%@",delegate.numberOfGoods,goodsYouSeeNow.imgAddress2];
                  NSURL *url2 = [NSURL URLWithString:strURL2];
                  NSURLSession *session2 = [NSURLSession sharedSession];
                  NSURLSessionDataTask *dataTask2 = [session2 dataTaskWithURL:url2 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                 {
                     viewForTableHead.imageView2.image = [UIImage imageWithData:data];
                     NSLog(@"获取第二张图片成功！");
                 }];
                  [dataTask2 resume];
                  
                  //获取第三张图片
                  NSString *strURL3 = [NSString stringWithFormat:@"http://42.96.178.214/img/%d/%@",delegate.numberOfGoods,goodsYouSeeNow.imgAddress3];
                  NSURL *url3 = [NSURL URLWithString:strURL3];
                  NSURLSession *session3 = [NSURLSession sharedSession];
                  NSURLSessionDataTask *dataTask3 = [session3 dataTaskWithURL:url3 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                 {
                     viewForTableHead.imageView3.image = [UIImage imageWithData:data];
                     NSLog(@"获取第三张图片成功！");
                 }];
                  [dataTask3 resume];
                  
                  
              }
              
              else
              {
                  NSLog(@"请求失败了");
              }
          }];
    
    //5.执行任务
    [dataTask resume];
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


#pragma mark -- 添加到购物车以及立即购买 相应事件
- (void)buttonAddCart:(UIButton *)sender
{
    //NSLog(@"加入购物车！");
    [UIView animateWithDuration:1 animations:^
    {
        viewForNumber.frame = CGRectMake(0, HL - 150, WL, 150);
    } completion:^(BOOL finished)
    {
        NSLog(@"动画完成！");
    }];
    
    viewForNumber.buyBlockTest = ^()
    {
        
    };
}

- (void)buttonBuyNow:(UIButton *)sender
{
    NSLog(@"立即购买！");
    
    viewForNumber.buyBlockTest = ^()
    {
        NSLog(@"这么用的？ zzzzzzz");
    };
}



@end
