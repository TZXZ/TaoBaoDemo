//
//  SLHomeSecondCell.h
//  TaoBaoDemo
//
//  Created by fang on 16/3/25.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;


@interface SLHomeSecondCell : UITableViewCell
{
    AppDelegate *delegate;
}


@property (assign, nonatomic) float widthLength;
@property (strong, nonatomic) UIImageView *imageViewHead;
@property (strong, nonatomic) UILabel *labelHead;

@property (strong, nonatomic) UIButton *button1;
@property (strong, nonatomic) UILabel *label1_1;
@property (strong, nonatomic) UILabel *label1_2;

@property (strong, nonatomic) UIButton *button2;
@property (strong, nonatomic) UILabel *label2_1;
@property (strong, nonatomic) UILabel *label2_2;

@property (strong, nonatomic) UIButton *button3;
@property (strong, nonatomic) UILabel *label3_1;
@property (strong, nonatomic) UILabel *label3_2;

@property (strong, nonatomic) UIButton *button4;
@property (strong, nonatomic) UILabel *label4_1;
@property (strong, nonatomic) UILabel *label4_2;

@property (strong, nonatomic) UIButton *button5;
@property (strong, nonatomic) UILabel *label5_1;
@property (strong, nonatomic) UILabel *label5_2;

@property (strong, nonatomic) UIButton *button6;
@property (strong, nonatomic) UILabel *label6_1;
@property (strong, nonatomic) UILabel *label6_2;

@property (copy, nonatomic) void (^SecondCellBlock)();


@end
