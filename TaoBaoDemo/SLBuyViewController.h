//
//  SLBuyViewController.h
//  TaoBaoDemo
//
//  Created by fang on 16/3/27.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLBuyCustomHeadView;
@class SLBuyNumberView;
@class AppDelegate;
@class SLGoodsDetail;


@interface SLBuyViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    SLBuyCustomHeadView *viewForTableHead;
    SLBuyNumberView *viewForNumber;
    AppDelegate *delegate;
    SLGoodsDetail *goodsYouSeeNow;
}


@property (nonatomic, strong) UITableView *tableView;            //最基础页面
@property (nonatomic, strong) UIView *viewForTableHeadView;

@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;
@property (nonatomic, strong) UIImage *image3;


@end
