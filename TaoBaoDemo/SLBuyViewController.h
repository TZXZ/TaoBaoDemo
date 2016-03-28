//
//  SLBuyViewController.h
//  TaoBaoDemo
//
//  Created by fang on 16/3/27.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLBuyCustomHeadView;

@interface SLBuyViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    SLBuyCustomHeadView *viewForTableHead;
}


@property (nonatomic, strong) UITableView *tableView;            //最基础页面
@property (nonatomic, strong) UIView *viewForTableHeadView;


@end
