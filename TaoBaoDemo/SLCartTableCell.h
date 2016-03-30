//
//  SLCartTableCell.h
//  TaoBaoDemo
//
//  Created by fang on 16/3/30.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLGoodsDetail.h"
#import "Masonry.h"

//16进制RGB的颜色转换
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//R G B 颜色
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

//红色
#define BASECOLOR_RED [UIColor \
colorWithRed:((float)((0xED5565 & 0xFF0000) >> 16))/255.0 \
green:((float)((0xED5565 & 0xFF00) >> 8))/255.0 \
blue:((float)(0xED5565 & 0xFF))/255.0 alpha:1.0]


//cell是否选中的回调
typedef void (^CartSelectBlock)(BOOL select);
//数量改变的回调
typedef void (^GoodsCountChange)();



@interface SLCartTableCell : UITableViewCell


//数量
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, copy) CartSelectBlock cartSelectBlock;
@property (nonatomic, copy) GoodsCountChange countAddBlock;
@property (nonatomic, copy) GoodsCountChange countCutBlock;


- (void)reloadDataWith:(SLGoodsDetail *)model;


@end
