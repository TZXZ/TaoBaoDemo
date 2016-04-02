//
//  SLBuyCustomHeadView.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/28.
//  Copyright © 2016年 sl. All rights reserved.
//
////////////////////////////////////////////////////////////////////
//                          _ooOoo_                               //
//                         o8888888o                              //
//                         88" . "88                              //
//                         (| ^_^ |)                              //
//                         O\  =  /O                              //
//                      ____/`---'\____                           //
//                    .'  \\|     |//  `.                         //
//                   /  \\|||  :  |||//  \                        //
//                  /  _||||| -:- |||||-  \                       //
//                  |   | \\\  -  /// |   |                       //
//                  | \_|  ''\---/''  |   |                       //
//                  \  .-\__  `-`  ___/-. /                       //
//                ___`. .'  /--.--\  `. . ___                     //
//              ."" '<  `.___\_<|>_/___.'  >'"".                  //
//            | | :  `- \`.;`\ _ /`;.`/ - ` : | |                 //
//            \  \ `-.   \_ __\ /__ _/   .-` /  /                 //
//      ========`-.____`-.___\_____/___.-`____.-'========         //
//                           `=---='                              //
//      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        //
//         佛祖保佑            永无BUG              永不修改         //
////////////////////////////////////////////////////////////////////


#import "SLBuyCustomHeadView.h"

@implementation SLBuyCustomHeadView

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
        float widthZ = frame.size.width;
        //float heightZ = frame.size.height;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, widthZ, widthZ * 0.8)];
        _scrollView.contentSize = CGSizeMake(widthZ * 3, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self addSubview:_scrollView];
        
        _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, widthZ, widthZ * 0.8)];
        _imageView1.image = [UIImage imageNamed:@""];
        [_scrollView addSubview:_imageView1];
        
        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(widthZ, 0, widthZ, widthZ * 0.8)];
        _imageView2.image = [UIImage imageNamed:@""];
        [_scrollView addSubview:_imageView2];
        
        _imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(widthZ * 2, 0, widthZ, widthZ * 0.8)];
        _imageView3.image = [UIImage imageNamed:@""];
        [_scrollView addSubview:_imageView3];
        
        _labelDetail = [[UILabel alloc] initWithFrame:CGRectMake(0 + 10, widthZ * 0.8 + 10, widthZ - 40 - 60, 40)];
        _labelDetail.numberOfLines = 2;
        _labelDetail.text = @"正在努力加载中...";          //记得待会从AppDelegate 里面取数
        _labelDetail.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_labelDetail];                              //添加商品详情文本框
        
        UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(widthZ - 40 - 30 - 0.5 - 15, widthZ * 0.8 + 10, 0.5, 40)];
        line0.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self addSubview:line0];                              //添加小分界线
        
        UIButton *buttonShare = [[UIButton alloc] initWithFrame:CGRectMake(widthZ - 40 - 20, widthZ * 0.8 + 10, 25, 25)];
        [buttonShare setImage:[UIImage imageNamed:@"buy_share.png"] forState:UIControlStateNormal];
        [buttonShare addTarget:self action:@selector(buttonShareAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonShare];                     //添加分享按钮
        
        UILabel *labelShare = [[UILabel alloc] initWithFrame:CGRectMake(widthZ - 40 - 20, widthZ * 0.8 + 25 + 10, 30, 20)];
        labelShare.text = @"分享";
        labelShare.font = [UIFont systemFontOfSize:11.0];
        labelShare.textAlignment = NSTextAlignmentCenter;
        [self addSubview:labelShare];                       //添加“分享”文本框
        
        _labelMoneySign = [[UILabel alloc] initWithFrame:CGRectMake(0 + 10, widthZ * 0.8 + 40 + 10 + 10, 20, 20)];
        _labelMoneySign.text = @"￥";
        _labelMoneySign.textColor = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:26/255.0 alpha:1];
        [self addSubview:_labelMoneySign];
        
        _labelMoneyLow = [[UILabel alloc] initWithFrame:CGRectMake(0 + 10 + 20 + 5, widthZ * 0.8 + 40 + 10 + 10, 60, 20)];
        _labelMoneyLow.text = @"0.00";
        _labelMoneyLow.textColor = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:26/255.0 alpha:1];
        [self addSubview:_labelMoneyLow];
        
        _labelMoneyline= [[UILabel alloc] initWithFrame:CGRectMake(0 + 10 + 20 + 5 + 60, widthZ * 0.8 + 40 + 10 + 10, 20, 20)];
        //_labelMoneyline.text = @"--";
        [self addSubview:_labelMoneyline];                  //添加价格中间线条
        
        _labelMoneyHigh = [[UILabel alloc] initWithFrame:CGRectMake(0 + 10 + 20 + 5 + 60 + 20, widthZ * 0.8 + 40 + 10 + 10, 60, 20)];
        //_labelMoneyHigh.text = @"18825";
        _labelMoneyHigh.textColor = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:26/255.0 alpha:1];
        [self addSubview:_labelMoneyHigh];                  //添加最高价格
        
        _labelTest1 = [[UILabel alloc] initWithFrame:CGRectMake(0 + 10, widthZ * 0.8 + 40 + 10 + 10 + 20 + 10, 80 + 20, 20)];
        _labelTest1.font = [UIFont systemFontOfSize:12.0];
        _labelTest1.text = @"快递：免运费";
        _labelTest1.textColor = [UIColor grayColor];
        [self addSubview:_labelTest1];                      //添加该商品快递情况
        
        _labelTest2 = [[UILabel alloc] initWithFrame:CGRectMake(0 + 10 + 90 + 20, widthZ * 0.8 + 40 + 10 + 10 + 20 + 10, 80, 20)];
        _labelTest2.font = [UIFont systemFontOfSize:12.0];
        _labelTest2.text = @"月销2583笔";
        _labelTest2.textColor = [UIColor grayColor];
        [self addSubview:_labelTest2];                      //添加该商品销量情况
        
        _labelTest3 = [[UILabel alloc] initWithFrame:CGRectMake(0 + 10 + 90 + 20 + 90 + 20, widthZ * 0.8 + 40 + 10 + 10 + 20 + 10, 80, 20)];
        _labelTest3.font = [UIFont systemFontOfSize:12.0];
        _labelTest3.text = @"广东深圳";
        _labelTest3.textColor = [UIColor grayColor];
        [self addSubview:_labelTest3];                      //添加该商品卖家地点情况

        
        
    }
    
    return self;
}


- (void)buttonShareAction:(UIButton *)sender
{
    NSLog(@"我是分享按钮");
}












@end
