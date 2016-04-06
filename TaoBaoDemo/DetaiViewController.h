//
//  DetaiViewController.h
//  TaoBaoDemo
//
//  Created by fang on 16/3/21.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DetaiViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    AppDelegate *appDelegate;
    __block int fileCount;
}


@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIImageView *imageViewForCell;

@end
