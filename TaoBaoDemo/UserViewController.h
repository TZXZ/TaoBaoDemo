//
//  UserViewController.h
//  TaoBaoDemo
//
//  Created by fang on 16/1/22.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *imageViewHead;
@property (strong, nonatomic) UILabel *labelUserName;

@end
