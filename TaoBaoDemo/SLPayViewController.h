//
//  SLPayViewController.h
//  TaoBaoDemo
//
//  Created by fang on 16/3/31.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLGoodsDetail.h"
#import "AppDelegate.h"

@interface SLPayViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    AppDelegate *delegate;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) SLGoodsDetail *goodsYouPayNow;
@property (weak, nonatomic) IBOutlet UILabel *labelPayMoney;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelPhone;


- (IBAction)viewBackAction:(UIBarButtonItem *)sender;
- (IBAction)payMoneyAction:(UIButton *)sender;


@end
