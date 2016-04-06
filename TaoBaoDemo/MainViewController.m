//
//  MainViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/1/22.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "MainViewController.h"
//#import "SLHomeTableViewCell.h"
#import "SLHomeSecondCell.h"
#import "SLSectionHeadView.h"
#import "SLHomeSearchButtonView.h"
#import "SLBuyViewController.h"
#import "SLSearchViewController.h"
#import "SLNewsViewController.h"

#import "SubLBXScanViewController.h"

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height
#define NUM 5                                   //滚动广告的图片数量
#define NUM_LoadImage 32                        //商品图片数量

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    self.numberNewsPage = 0;
    
    
//初始化顶部的toolBar及背景图片  和搜索按钮
    UIToolbar *myToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, WL, 44)];
    UIView *viewForToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WL, 44)];
    viewForToolBar.backgroundColor = [UIColor colorWithRed:255/255.0 green:79/255.0 blue:45/255.0 alpha:1];
    [myToolBar addSubview:viewForToolBar];                    //将背景添加到myToolBar上面去
    //初始化左边的扫一扫按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton addTarget:self action:@selector(scanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"saoyisao.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(9, 30, 40, 20)];
    leftLabel.text = @"扫一扫";
    leftLabel.textColor = [UIColor whiteColor];
    [leftLabel setTextAlignment:NSTextAlignmentCenter];
    leftLabel.font = [UIFont systemFontOfSize:9.0];
    
    //初始化右边的消息按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [rightButton setImage:[UIImage imageNamed:@"xiaoxi.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(WL - 48, 30, 40, 20)];
    rightLabel.text = @"消息";
    rightLabel.textColor = [UIColor whiteColor];
    [rightLabel setTextAlignment:NSTextAlignmentCenter];
    rightLabel.font = [UIFont systemFontOfSize:9.0];
    
//初始化搜索按钮
    SLHomeSearchButtonView *searchButtonView = [[SLHomeSearchButtonView alloc] initWithFrame:CGRectMake(80, 0, WL - 160, 44)];
    __weak MainViewController *blockSelf = self;
    searchButtonView.cameraButtonBlock = ^()
    {
        [blockSelf cameraAction];
    };
    searchButtonView.searchButtonBlock = ^()
    {
        [blockSelf searchAction];
    };
    [myToolBar addSubview:searchButtonView];                 //添加搜索按钮
    
    
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
    self.viewForTableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WL, WL * 0.3 + 150 + 60 + 10 + 160)];
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
    topLine.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    [self.viewForRotatingNews addSubview:topLine];                   //添加顶部线条到新闻滚动视图
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(99, 15, 1, 30)];
    rightLine.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
    [self.viewForRotatingNews addSubview:rightLine];                 //添加右边线条到新闻滚动视图里面去
    self.imageViewNews = [[UIImageView alloc] initWithFrame:CGRectMake(120, 5, WL - 100 - 20 - 20, 50)];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(startRotatingNews) userInfo:nil repeats:YES];
    self.imageViewNews.image = [UIImage imageNamed:@"rotating_news_0.png"];
    _imageViewNews.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToWebForNews)];
    tapRecognizer.numberOfTapsRequired = 1;
    [_imageViewNews addGestureRecognizer:tapRecognizer];
    [self.viewForRotatingNews addSubview:self.imageViewNews];                 //将右边的imageView 添加到新闻滚动视图上面去
    [self.viewForTableHeadView addSubview:self.viewForRotatingNews];          //将新闻滚动视图添加到表头视图上面去
    
//初始化表头视图中的最下面的一块视图
    UIView *graySpace = [[UIView alloc] initWithFrame:CGRectMake(0, WL * 0.3 + 150 + 60, WL, 10)];
    graySpace.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
    [self.viewForTableHeadView addSubview:graySpace];              //添加灰色部分，美化
    headViewLast = [[SLSectionHeadView alloc] initWithFrame:CGRectMake(0, WL * 0.3 + 150 + 60 + 10, WL, 160)];
    headViewLast.owner = self;
    [self.viewForTableHeadView addSubview:headViewLast];            //添加最后部分视图
    
//开始网络请求图片数据
    [self getImageForButtons];
    self.couldLoadImage = NO;         //该值判断能否加载图片
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


#pragma mark -- scan button action  扫一扫按钮事件   以及   相机按钮   以及搜索按钮
- (void)scanButtonAction:(UIButton *)sender
{
    //NSLog(@"扫一扫");
    SubLBXScanViewController *viewController = [SubLBXScanViewController new];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)cameraAction
{
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)searchAction
{
    SLSearchViewController *searchViewController = [[SLSearchViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:navController animated:YES completion:nil];
}


#pragma mark -- WHScrollViewViewDelegate     滚动广告的代理事件，响应点击事件的
- (void)didClickPage:(WHScrollAndPageView *)view atIndex:(NSInteger)index
{
    NSLog(@"点击了滚动广告的第%ld页",(long)index);
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
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您现在点击的以及这周围的10个圆形按钮都还没有写事件，请尝试其他按钮" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark -- 开始新闻滚动事件 startRotatingNews    以及    新闻页面的跳转
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

- (void)moveToWebForNews
{
    //NSLog(@"我要去新闻页面了！");
    
    SLNewsViewController *newsController = [[SLNewsViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:newsController];
    [self presentViewController:navController animated:YES completion:nil];
}


#pragma mark -- TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView           //暂时只做4个section 最后一个collection view 有时间再做
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)      //第一个Section 中的cell初始化及加入队列
    {
        static NSString *cellID = @"SectionZero";
        SLHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        cell.delegate = self;      //签协议
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
        
        //判断是否有图片数据，有的话就加载，没有就忽略
        if (_couldLoadImage)
        {
            [cell.button1 setImage:[_dicForImage objectForKey:@"image4.png"] forState:UIControlStateNormal];
            [cell.button2 setImage:[_dicForImage objectForKey:@"image5.png"] forState:UIControlStateNormal];
            [cell.button3 setImage:[_dicForImage objectForKey:@"image6.png"] forState:UIControlStateNormal];
            [cell.button4 setImage:[_dicForImage objectForKey:@"image7.png"] forState:UIControlStateNormal];
            [cell.button5 setImage:[_dicForImage objectForKey:@"image8.png"] forState:UIControlStateNormal];
            [cell.button6 setImage:[_dicForImage objectForKey:@"image9.png"] forState:UIControlStateNormal];
            [cell.button7 setImage:[_dicForImage objectForKey:@"image10.png"] forState:UIControlStateNormal];
            [cell.button8 setImage:[_dicForImage objectForKey:@"image11.png"] forState:UIControlStateNormal];
        }
        
        return cell;
    }
    
    else if (indexPath.section == 1)    //第二个Section 中的cell初始化及加入队列
    {
        static NSString *cellID = @"SectionOne";
        SLHomeSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil)
        {
            cell = [SLHomeSecondCell alloc];
            cell.widthLength = WL;
            cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        //判断是否有图片，有就加载
        if (_couldLoadImage)
        {
            [cell.button1 setImage:[_dicForImage objectForKey:@"image12.png"] forState:UIControlStateNormal];
            [cell.button2 setImage:[_dicForImage objectForKey:@"image13.png"] forState:UIControlStateNormal];
            [cell.button3 setImage:[_dicForImage objectForKey:@"image14.png"] forState:UIControlStateNormal];
            [cell.button4 setImage:[_dicForImage objectForKey:@"image15.png"] forState:UIControlStateNormal];
            [cell.button5 setImage:[_dicForImage objectForKey:@"image16.png"] forState:UIControlStateNormal];
            [cell.button6 setImage:[_dicForImage objectForKey:@"image17.png"] forState:UIControlStateNormal];
        }
        __block MainViewController *blockSelf = self;
        cell.SecondCellBlock = ^()
        {
            SLBuyViewController *buyViewController = [[SLBuyViewController alloc] init];
            [blockSelf presentViewController:buyViewController animated:YES completion:nil];
        };
        
        return cell;
    }
    
    else if (indexPath.section == 2)    //第三个Section 中的cell初始化及加入队列
    {
        static NSString *cellID = @"SectionTwo";
        SLHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        //cell.delegate = self;         //签协议   用block做
        
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
        cell.label5_2.text = @"千元公务车";
        cell.label6_1.text = @"医药健康";
        cell.label6_2.text = @"1元兑美瞳";
        cell.label7_1.text = @"淘宝众筹";
        cell.label7_2.text = @"车载播放器";
        cell.label8_1.text = @"每日新品";
        cell.label8_2.text = @"找新品戳我";
        cell.imageViewHead.image = [UIImage imageNamed:@"good_goods.png"];
        cell.labelHead.text = @"特色好货";
        cell.labelHead.textColor = [UIColor colorWithRed:66/255.0 green:218/255.0 blue:255/255.0 alpha:1];
        
        //判断是否有图片数据，有的话就加载，没有就忽略
        if (_couldLoadImage)
        {
            [cell.button1 setImage:[_dicForImage objectForKey:@"image18.png"] forState:UIControlStateNormal];
            [cell.button2 setImage:[_dicForImage objectForKey:@"image19.png"] forState:UIControlStateNormal];
            [cell.button3 setImage:[_dicForImage objectForKey:@"image20.png"] forState:UIControlStateNormal];
            [cell.button4 setImage:[_dicForImage objectForKey:@"image21.png"] forState:UIControlStateNormal];
            [cell.button5 setImage:[_dicForImage objectForKey:@"image22.png"] forState:UIControlStateNormal];
            [cell.button6 setImage:[_dicForImage objectForKey:@"image23.png"] forState:UIControlStateNormal];
            [cell.button7 setImage:[_dicForImage objectForKey:@"image24.png"] forState:UIControlStateNormal];
            [cell.button8 setImage:[_dicForImage objectForKey:@"image25.png"] forState:UIControlStateNormal];
        }
        
        __weak MainViewController *weakSelf = self;
        cell.ForSectionTwoCell = ^()
        {
            SLBuyViewController *buyViewController = [[SLBuyViewController alloc] init];
            [weakSelf presentViewController:buyViewController animated:YES completion:nil];
        };
        
        return cell;
    }
    
    else if (indexPath.section == 3)           //第四个Section 中的cell初始化及加入队列
    {
        static NSString *cellID = @"SectionThree";
        SLHomeSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil)
        {
            cell = [SLHomeSecondCell alloc];
            cell.widthLength = WL;
            cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.imageViewHead.image = [UIImage imageNamed:@"hot_part.png"];
        cell.labelHead.text = @"热门市场";
        cell.labelHead.textColor = [UIColor greenColor];
        cell.label1_1.text = @"美食";
        cell.label1_2.text = @"春游也要吃";
        cell.label2_1.text = @"内衣";
        cell.label2_2.text = @"性感装备";
        cell.label3_1.text = @"数码";
        cell.label3_2.text = @"潮流新奇特";
        cell.label4_1.text = @"汽车";
        cell.label4_2.text = @"春季包养季";
        cell.label5_1.text = @"家电";
        cell.label5_2.text = @"送妈妈实用";
        cell.label6_1.text = @"箱包";
        cell.label6_2.text = @"潮流特卖";
        
        //判断是否有图片，有就加载
        if (_couldLoadImage)
        {
            [cell.button1 setImage:[_dicForImage objectForKey:@"image26.png"] forState:UIControlStateNormal];
            [cell.button2 setImage:[_dicForImage objectForKey:@"image27.png"] forState:UIControlStateNormal];
            [cell.button3 setImage:[_dicForImage objectForKey:@"image28.png"] forState:UIControlStateNormal];
            [cell.button4 setImage:[_dicForImage objectForKey:@"image29.png"] forState:UIControlStateNormal];
            [cell.button5 setImage:[_dicForImage objectForKey:@"image30.png"] forState:UIControlStateNormal];
            [cell.button6 setImage:[_dicForImage objectForKey:@"image31.png"] forState:UIControlStateNormal];
        }
        
        __block MainViewController *blockSelf = self;
        cell.SecondCellBlock = ^()                //选中的回调
        {
            SLBuyViewController *buyViewController = [[SLBuyViewController alloc] init];
            [blockSelf presentViewController:buyViewController animated:YES completion:nil];
        };
        
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

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


#pragma mark -- 从服务器获取商品图片 相关方法
- (void)getImageForButtons                          //从服务器获取图片
{
    self.dicForImage = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < NUM_LoadImage; i ++)
    {
        //1.确定请求路径
        NSString *strURL = [NSString stringWithFormat:@"http://42.96.178.214/img/image%d.png",i];
        NSURL *url = [NSURL URLWithString:strURL];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
            //NSLog(@"当前线程为 %@",[NSThread currentThread]);
            UIImage *image = [UIImage imageWithData:data];
            [self.dicForImage setObject:image forKey:[NSString stringWithFormat:@"image%d.png",i]];
        }];
        
        //5.执行任务
        [dataTask resume];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(watchingForSession:) userInfo:nil repeats:YES];
    
}

- (void)watchingForSession:(NSTimer *)timer         //监测图片数据是否加载完成，如果完成就刷新页面
{
    
    if ([_dicForImage allKeys].count == NUM_LoadImage)
    {
        NSLog(@"数据请求完成,我要开始刷新table view");
        [timer invalidate];
        [NSThread sleepForTimeInterval:1];
        
        //先加载表头视图里面的图片
        [headViewLast.button1 setImage:[_dicForImage objectForKey:@"image0.png"] forState:UIControlStateNormal];
        [headViewLast.button2 setImage:[_dicForImage objectForKey:@"image1.png"] forState:UIControlStateNormal];
        [headViewLast.button3 setImage:[_dicForImage objectForKey:@"image2.png"] forState:UIControlStateNormal];
        [headViewLast.button4 setImage:[_dicForImage objectForKey:@"image3.png"] forState:UIControlStateNormal];
        
        
        _couldLoadImage = YES;
        [self.tableView reloadData];
    }
    
}


#pragma mark -- SLHomeTableViewCellDelegate   点击Section0 和Section2 时响应用户的代理事件
- (void)actWhenUserTouchThisCell
{
    SLBuyViewController *buyViewController = [[SLBuyViewController alloc] init];
    [self presentViewController:buyViewController animated:YES completion:nil];
}






@end
