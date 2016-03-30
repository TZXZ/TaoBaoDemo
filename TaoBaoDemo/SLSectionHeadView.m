//
//  SLSectionHeadView.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/25.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLSectionHeadView.h"
#import "SLBuyViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"

@implementation SLSectionHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //初始化第一个button
        _button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 160)];
        _button1.tag = 175;
        [_button1 addTarget:self action:@selector(fourButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button1];         //添加第一个button 上去
        
        float widthLength = frame.size.width;
        self.imageView1_title = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        self.imageView1_title.image = [UIImage imageNamed:@"clock_1.png"];
        [_button1 addSubview:_imageView1_title];           //添加时钟图标
        
        _label1_title = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 150 - 30, 20)];
        _label1_title.text = @"淘抢购";
        _label1_title.textColor = [UIColor redColor];
        [_button1 addSubview:_label1_title];             //添加button1特定的标题
        
        _label1_detal = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 150 - 10, 20)];
        _label1_detal.font = [UIFont systemFontOfSize:12.0];
        _label1_detal.text = @"纯棉T恤买1送1";
        [_button1 addSubview:_label1_detal];              //添加该button1 的商品介绍
        
        UIView *blackView1 = [[UIView alloc] initWithFrame:CGRectMake(10, 60, 18, 20)];
        blackView1.backgroundColor = [UIColor blackColor];
        blackView1.layer.cornerRadius = 2;
        blackView1.layer.masksToBounds = YES;
        [_button1 addSubview:blackView1];           //添加第一个背景黑框
        
        UILabel *labelT_T1 = [[UILabel alloc] initWithFrame:CGRectMake(28, 60, 4, 20)];
        labelT_T1.text = @":";
        labelT_T1.font = [UIFont systemFontOfSize:15.0];
        [labelT_T1 setTextAlignment:NSTextAlignmentCenter];
        [_button1 addSubview:labelT_T1];                             //添加第一个黑色冒号
        
        UIView *blackView2 = [[UIView alloc] initWithFrame:CGRectMake(10 + 22 + 0.5, 60, 19 - 1, 20)];
        blackView2.backgroundColor = [UIColor blackColor];
        blackView2.layer.cornerRadius = 2;
        blackView2.layer.masksToBounds = YES;
        [_button1 addSubview:blackView2];           //添加第二个背景黑框
        UILabel *labelT_T2 = [[UILabel alloc] initWithFrame:CGRectMake(10 + 18 + 4 + 19, 60, 4, 20)];
        labelT_T2.text = @":";
        labelT_T2.font = [UIFont systemFontOfSize:15.0];
        [labelT_T2 setTextAlignment:NSTextAlignmentCenter];
        [_button1 addSubview:labelT_T2];                             //添加第二个黑色冒号
        
        UIView *blackView3 = [[UIView alloc] initWithFrame:CGRectMake(10 + 22 + 22 + 1, 60, 19, 20)];
        blackView3.backgroundColor = [UIColor blackColor];
        blackView3.layer.cornerRadius = 2;
        blackView3.layer.masksToBounds = YES;
        [_button1 addSubview:blackView3];           //添加第三个背景黑框
        
        _label1_time = [[UILabel alloc] initWithFrame:CGRectMake(10 + 1, 60, 150 - 10, 20)];
        _label1_time.font = [UIFont systemFontOfSize:15.0];
        _label1_time.textColor = [UIColor whiteColor];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startTimeCounting) userInfo:nil repeats:YES];
        _numberOfTime = 1800;
        [_button1 addSubview:_label1_time];                //添加倒计时文本框
        
        
        //初始化第二个button
        _button2 = [[UIButton alloc] initWithFrame:CGRectMake(150, 0, widthLength - 150, 80)];
        _button2.tag = 176;
        [_button2 addTarget:self action:@selector(fourButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button2];         //添加第二个button 上去
        
        _imageView2_title = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        _imageView2_title.image = [UIImage imageNamed:@"big_finger.png"];
        [_button2 addSubview:_imageView2_title];        //添加button2 的标题图片
        
        _label2_title = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, widthLength - 150 - 30, 20)];
        _label2_title.text = @"有好货";
        _label2_title.textColor = [UIColor blueColor];
        [_button2 addSubview:_label2_title];             //添加button2特定标题
        
        _label2_detail = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, widthLength - 150 - 10, 20)];
        _label2_detail.font = [UIFont systemFontOfSize:12.0];
        _label2_detail.text = @"好品味从挑剔开始";
        [_button2 addSubview:_label2_detail];             //添加button2的详细介绍
        
        _label2_weird = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + 20 + 5 + 20, widthLength - 150 - 10, 20)];
        _label2_weird.font = [UIFont systemFontOfSize:12.0];
        _label2_weird.text = @"品质生活指南";
        _label2_weird.textColor = [UIColor colorWithRed:166/255.0 green:226/255.0 blue:255/255.0 alpha:1.0];
        [_button2 addSubview:_label2_weird];               //奇怪的文本框
        
        
        //初始化第三个button
        _button3 = [[UIButton alloc] initWithFrame:CGRectMake(150, 80, (widthLength - 150) / 2, 80)];
        _button3.tag = 177;
        [_button3 addTarget:self action:@selector(fourButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button3];                   //添加第三个button上去
        
        _imageView3_title = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 15, 15)];
        _imageView3_title.image = [UIImage imageNamed:@"love_shop.png"];
        [_button3 addSubview:_imageView3_title];            //添加button3 的标题图片
        
        _label3_title = [[UILabel alloc] initWithFrame:CGRectMake(10 + 15, 10, (widthLength - 150) / 2 - 25, 15)];
        _label3_title.text = @"爱逛街";
        _label3_title.font = [UIFont systemFontOfSize:15.0];
        _label3_title.textColor = [UIColor colorWithRed:224/255.0 green:25/255.0 blue:255/255.0 alpha:1];
        [_button3 addSubview:_label3_title];               //添加button3的标题
        
        _label3_detail = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, (widthLength - 150) / 2 - 10, 15)];
        _label3_detail.font = [UIFont systemFontOfSize:10.0];
        _label3_detail.text = @"可爱的你会喜欢";
        [_button3 addSubview:_label3_detail];                 //添加button3的介绍
        
        //初始化第四个button
        _button4 = [[UIButton alloc] initWithFrame:CGRectMake(150 + (widthLength - 150) / 2, 80, (widthLength - 150) / 2, 80)];
        _button4.tag = 178;
        [_button4 addTarget:self action:@selector(fourButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button4];                   //添加第三个button上去
        
        _imageView4_title = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 15, 15)];
        _imageView4_title.image = [UIImage imageNamed:@"shop_list.png"];
        [_button4 addSubview:_imageView4_title];            //添加button3 的标题图片
        
        _label4_title = [[UILabel alloc] initWithFrame:CGRectMake(10 + 15, 10, (widthLength - 150) / 2 - 25, 15)];
        _label4_title.text = @"必买清单";
        _label4_title.font = [UIFont systemFontOfSize:14.0];
        _label4_title.textColor = [UIColor colorWithRed:255/255.0 green:86/255.0 blue:123/255.0 alpha:1];
        [_button4 addSubview:_label4_title];               //添加button3的标题
        
        _label4_detail = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, (widthLength - 150) / 2 - 10, 15)];
        _label4_detail.font = [UIFont systemFontOfSize:10.0];
        _label4_detail.text = @"都帮您整理好啦";
        [_button4 addSubview:_label4_detail];                 //添加button3的介绍
        
        
        //添加线条优化界面
        UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(150 - 0.5, 0, 0.5, 160)];
        line0.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self addSubview:line0];                 //添加第一条竖线
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(150 + (widthLength - 150) / 2 - 0.5, 80, 0.5, 80)];
        line1.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self addSubview:line1];            //添加第二条竖线
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(150, 80 - 0.5, widthLength - 150, 0.5)];
        line2.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self addSubview:line2];             //添加第一条横线
        
        
    }
    
    
    
    
    return self;
}


- (void)fourButtonAction:(UIButton *)sender
{
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (sender.tag == 175)
    {
        delegate.numberOfGoods = 10001;
    }
    else if (sender.tag == 176)
    {
        delegate.numberOfGoods = 10002;
    }
    else if (sender.tag == 177)
    {
        delegate.numberOfGoods = 10003;
    }
    else if (sender.tag == 178)
    {
        delegate.numberOfGoods = 10004;
    }
    
    SLBuyViewController *buyViewController = [[SLBuyViewController alloc] init];
    [self.owner presentViewController:buyViewController animated:YES completion:nil];
}

- (void)startTimeCounting
{
    NSInteger minute = _numberOfTime / 60;
    NSInteger second = _numberOfTime - minute * 60;
    self.label1_time.text = [NSString stringWithFormat:@"00:%02ld:%02ld",(long)minute,(long)second];
    self.numberOfTime -= 1;
    if (self.numberOfTime == 0)
    {
        self.numberOfTime = 1800;
    }
}





@end
