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
#import "LoginViewController.h"
#import "SLPayViewController.h"

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
    [self.view addSubview:buttonService];            //添加客服按钮
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 20, 20)];
    imageView1.image = [UIImage imageNamed:@"ali_server.png"];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 5 + 20, 20, 20)];
    label1.font = [UIFont systemFontOfSize:9.0];
    label1.text = @"客服";
    [buttonService addSubview:imageView1];
    [buttonService addSubview:label1];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(49 - 0.5, HL - 49, 0.5, 49)];
    line1.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:line1];                  //添加右边线条
    
    UIButton *buttonStore = [[UIButton alloc] initWithFrame:CGRectMake(49, HL - 49, 49, 49)];
    //[buttonStore setImage:[UIImage imageNamed:@"store_image.png"] forState:UIControlStateNormal];
    [self.view addSubview:buttonStore];            //添加店铺按钮
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 20, 20)];
    imageView2.image = [UIImage imageNamed:@"ali_store.png"];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(12, 5 + 20, 20, 20)];
    label2.font = [UIFont systemFontOfSize:9.0];
    label2.text = @"店铺";
    [buttonStore addSubview:imageView2];
    [buttonStore addSubview:label2];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(49 + 49 - 0.5, HL - 49, 0.5, 49)];
    line2.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:line2];                 //添加右边线条
    
    UIButton *buttonCollect = [[UIButton alloc] initWithFrame:CGRectMake(49 + 49, HL - 49, 49, 49)];
    //[buttonCollect setImage:[UIImage imageNamed:@"collect_image.png"] forState:UIControlStateNormal];
    [self.view addSubview:buttonCollect];            //添加收藏按钮
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 20, 20)];
    imageView3.image = [UIImage imageNamed:@"ali_collect.png"];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(12, 5 + 20, 20, 20)];
    label3.font = [UIFont systemFontOfSize:9.0];
    label3.text = @"收藏";
    [buttonCollect addSubview:imageView3];
    [buttonCollect addSubview:label3];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(49 + 49 + 49 - 0.5, HL - 49, 0.5, 49)];
    line3.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:line3];                 //添加右边线条
    
    float tempL = (WL - 49 - 49 - 49) / 2;
    UIButton *buttonAddCart = [[UIButton alloc] initWithFrame:CGRectMake(147, HL - 49, tempL, 49)];
    buttonAddCart.backgroundColor = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:26/255.0 alpha:1];
    [buttonAddCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    buttonAddCart.titleLabel.font = [UIFont systemFontOfSize:15.0];
    buttonAddCart.titleLabel.textColor = [UIColor whiteColor];
    [buttonAddCart addTarget:self action:@selector(buttonAddCart:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonAddCart];               //添加加入购物车按钮
    
    UIButton *buttonBuyNow = [[UIButton alloc] initWithFrame:CGRectMake(147 + tempL, HL - 49, tempL, 49)];
    buttonBuyNow.backgroundColor = [UIColor redColor];
    [buttonBuyNow setTitle:@"立即购买" forState:UIControlStateNormal];
    buttonBuyNow.titleLabel.font = [UIFont systemFontOfSize:15.0];
    buttonBuyNow.titleLabel.textColor = [UIColor whiteColor];
    [buttonBuyNow addTarget:self action:@selector(buttonBuyNow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonBuyNow];               //添加加入购物车按钮
}

- (void)getGoodsMessageFromServer
{
    //1.确定请求路径
    NSString *strURL = [NSString stringWithFormat:@"http://42.96.178.214/php/queryZ.php?number=%d",delegate.numberOfGoods];
    //NSString *strURL = [NSString stringWithFormat:@"http://localhost/queryZ.php?number=%d",delegate.numberOfGoods];
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
          {
              NSLog(@"当前线程为 %@",[NSThread currentThread]);
              if (!error)
              {
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                  //NSLog(@"dic = %@",dic);      //获取当前商品所有信息
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
                  
                  NSLog(@"goodsYouSeeNow.name = %@",goodsYouSeeNow.name);
                  
//                  viewForTableHead.labelDetail.text = goodsYouSeeNow.describe;
//                  viewForTableHead.labelMoneyLow.text = goodsYouSeeNow.price;
//                  viewForTableHead.labelTest1.text = goodsYouSeeNow.postState;
//                  viewForTableHead.labelTest2.text = goodsYouSeeNow.saleState;
//                  viewForTableHead.labelTest3.text = goodsYouSeeNow.addressState;
                  
                  //获取第一张图片
                  NSString *strURL1 = [NSString stringWithFormat:@"http://42.96.178.214/img/%d/%@",delegate.numberOfGoods,goodsYouSeeNow.imgAddress1];
                  NSURL *url1 = [NSURL URLWithString:strURL1];
                  NSURLSession *session1 = [NSURLSession sharedSession];
                  NSURLSessionDataTask *dataTask1 = [session1 dataTaskWithURL:url1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                  {
                      //_image1 = [UIImage imageWithData:data];
                      //NSLog(@"获取第一张图片成功！");
                      dispatch_async(dispatch_get_main_queue(), ^
                                     {
                                         viewForTableHead.imageView1.image = [UIImage imageWithData:data];
                                     });
                      
                  }];
                  [dataTask1 resume];
                  
                  //获取第二张图片
                  NSString *strURL2 = [NSString stringWithFormat:@"http://42.96.178.214/img/%d/%@",delegate.numberOfGoods,goodsYouSeeNow.imgAddress2];
                  NSURL *url2 = [NSURL URLWithString:strURL2];
                  NSURLSession *session2 = [NSURLSession sharedSession];
                  NSURLSessionDataTask *dataTask2 = [session2 dataTaskWithURL:url2 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                 {
                     //_image2 = [UIImage imageWithData:data];
                     //NSLog(@"获取第二张图片成功！");
                     dispatch_async(dispatch_get_main_queue(), ^
                                    {
                                        viewForTableHead.imageView2.image = [UIImage imageWithData:data];
                                    });
                 }];
                  [dataTask2 resume];
                  
                  //获取第三张图片
                  NSString *strURL3 = [NSString stringWithFormat:@"http://42.96.178.214/img/%d/%@",delegate.numberOfGoods,goodsYouSeeNow.imgAddress3];
                  NSURL *url3 = [NSURL URLWithString:strURL3];
                  NSURLSession *session3 = [NSURLSession sharedSession];
                  NSURLSessionDataTask *dataTask3 = [session3 dataTaskWithURL:url3 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                 {
                     //_image3 = [UIImage imageWithData:data];
                     //NSLog(@"获取第三张图片成功！");
                     dispatch_async(dispatch_get_main_queue(), ^
                                    {
                                        viewForTableHead.imageView3.image = [UIImage imageWithData:data];
                                    });
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
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(soSlowToLoadMessage:) userInfo:nil repeats:YES];
}


#pragma mark -- 将网络请求完成的数据另外赋值，不然延迟加载很坑爹
- (void)soSlowToLoadMessage:(NSTimer *)timer
{
    if (goodsYouSeeNow.name != nil)
    {
        [timer invalidate];
        NSLog(@"物品数据详情数据请求成功，我要开始加载");
        
        viewForTableHead.labelDetail.text = goodsYouSeeNow.describe;
        viewForTableHead.labelMoneyLow.text = goodsYouSeeNow.price;
        viewForTableHead.labelTest1.text = goodsYouSeeNow.postState;
        viewForTableHead.labelTest2.text = goodsYouSeeNow.saleState;
        viewForTableHead.labelTest3.text = goodsYouSeeNow.addressState;
        
    }
//    if (_image1 != nil)
//    {
//        viewForTableHead.imageView1.image = _image1;
//    }
//    if (_image2 != nil)
//    {
//        viewForTableHead.imageView2.image = _image2;
//    }
//    if (_image3 != nil)
//    {
//        viewForTableHead.imageView3.image = _image3;
//    }
//    
//    if (goodsYouSeeNow.name != nil && _image1 != nil && _image2 != nil && _image3 != nil)
//    {
//        [timer invalidate];
//    }
    
    
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
- (void)buttonAddCart:(UIButton *)sender                //购物车按钮事件
{
    if (delegate.userHasLogin)
    {
        [UIView animateWithDuration:1 animations:^
         {
             viewForNumber.frame = CGRectMake(0, HL - 150, WL, 150);
         } completion:^(BOOL finished)
         {}];
        
        __block SLBuyViewController *blockSelf = self;            //防止循环引用
        viewForNumber.buyBlockTest = ^(NSString *strNum)
        {
            [blockSelf getNumberViewDown];
            [blockSelf addGoodsToCart:strNum];
        };
    }
    
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户未登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我再逛逛" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
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

- (void)buttonBuyNow:(UIButton *)sender                 //立即购买按钮事件
{
    if (delegate.userHasLogin)
    {
        //NSLog(@"等下，马上就要写这里了");
        [UIView animateWithDuration:1 animations:^
         {
             viewForNumber.frame = CGRectMake(0, HL - 150, WL, 150);
         } completion:^(BOOL finished)
         {}];
        
        __weak SLBuyViewController *blockSelf = self;            //防止循环引用
        viewForNumber.buyBlockTest = ^(NSString *strNum)
        {
            NSLog(@"这里代码执行了吗");
            //[blockSelf getNumberViewDown];
            [blockSelf buyGoodsNow:strNum];
        };
    }
    
    else        //用户未登录的时候提示用户
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户未登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"我再逛逛" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"马上登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
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

- (void)getNumberViewDown                   //将选择数量视图降下去
{
    [UIView animateWithDuration:1 animations:^
    {
        viewForNumber.frame = CGRectMake(0, HL, WL, 150);
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"成功添加至购物车" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)addGoodsToCart:(NSString *)str                  //添加到购物车要显示的数组中去
{
    NSLog(@"当前购买的商品数量是 %@",str);
    
    for (int i = 0; i < delegate.arrayForCart.count; i ++)
    {
        NSString *tempName = [[delegate.arrayForCart objectAtIndex:i] name];
        //NSLog(@"tempName = %@",tempName);
        
        if ([tempName isEqualToString:goodsYouSeeNow.name])
        {
            SLGoodsDetail *goodsTemp = [delegate.arrayForCart objectAtIndex:i];
            int newNumber = goodsTemp.countOfNeed + str.intValue;
            goodsTemp.countOfNeed = newNumber;
            [delegate.arrayForCart replaceObjectAtIndex:i withObject:goodsTemp];
            
            return;
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [NSDate date];
    NSString *strDate = [dateFormatter stringFromDate:date];
    //NSLog(@"strDate = %@",strDate);
    goodsYouSeeNow.dateStr = strDate;
    goodsYouSeeNow.countOfNeed = str.intValue;
    [delegate.arrayForCart addObject:goodsYouSeeNow];


}

- (void)buyGoodsNow:(NSString *)str           //跳转到购物详情页面
{
    goodsYouSeeNow.countOfNeed = str.intValue;
    
    SLPayViewController *payViewController = [[SLPayViewController alloc] init];
    payViewController.goodsYouPayNow = goodsYouSeeNow;
    [self presentViewController:payViewController animated:YES completion:nil];
}


@end
