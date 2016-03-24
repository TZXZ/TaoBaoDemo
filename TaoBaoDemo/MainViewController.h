//
//  MainViewController.h
//  TaoBaoDemo
//
//  Created by fang on 16/1/22.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHScrollAndPageView.h"

@interface MainViewController : UIViewController<WHScrollViewViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIView *viewForTableHeadView;
@property (strong, nonatomic) UIView *viewForRotatingNews;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) UIImageView *imageViewNews;
@property (assign, nonatomic) int numberNewsPage;

@property (strong, nonatomic) WHScrollAndPageView *whView;

@end
