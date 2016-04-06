//
//  SLSearchViewController.h
//  TaoBaoDemo
//
//  Created by fang on 16/4/4.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface SLSearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    AppDelegate *delegate;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *mutArrayGoodsOriginal;
@property (strong, nonatomic) NSMutableArray *mutArrayGoodsCopy;
@property (strong, nonatomic) NSDictionary *dicGoodsInfo;


@end
