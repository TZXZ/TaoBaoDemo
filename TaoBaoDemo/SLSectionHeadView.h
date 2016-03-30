//
//  SLSectionHeadView.h
//  TaoBaoDemo
//
//  Created by fang on 16/3/25.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainViewController;
@class AppDelegate;

@interface SLSectionHeadView : UIView
{
    AppDelegate *delegate;
}


@property (nonatomic, strong) MainViewController *owner;

@property (nonatomic, strong) UIImageView *imageView1_title;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UILabel *label1_title;
@property (nonatomic, strong) UILabel *label1_detal;
@property (nonatomic, strong) UILabel *label1_time;
@property (nonatomic, assign) NSInteger numberOfTime;

@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIImageView *imageView2_title;
@property (nonatomic, strong) UILabel *label2_title;
@property (nonatomic, strong) UILabel *label2_detail;
@property (nonatomic, strong) UILabel *label2_weird;

@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIImageView *imageView3_title;
@property (nonatomic, strong) UILabel *label3_title;
@property (nonatomic, strong) UILabel *label3_detail;

@property (nonatomic, strong) UIButton *button4;
@property (nonatomic, strong) UIImageView *imageView4_title;
@property (nonatomic, strong) UILabel *label4_title;
@property (nonatomic, strong) UILabel *label4_detail;

@end
