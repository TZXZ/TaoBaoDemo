//
//  MainViewController.h
//  TaoBaoDemo
//
//  Created by fang on 16/1/22.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "WHScrollAndPageView.h"
#import "SLHomeTableViewCell.h"

@class SLSectionHeadView;

@interface MainViewController : UIViewController<WHScrollViewViewDelegate,UITableViewDataSource,UITableViewDelegate,NSURLSessionDataDelegate, SLHomeTableViewCellDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    SLSectionHeadView *headViewLast;
}

@property (strong, nonatomic) UIView *viewForTableHeadView;
@property (strong, nonatomic) UIView *viewForRotatingNews;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) UIImageView *imageViewNews;
@property (assign, nonatomic) int numberNewsPage;

@property (strong, nonatomic) WHScrollAndPageView *whView;

@property (strong, nonatomic) NSMutableData *dataResponse;
@property (strong, nonatomic) NSMutableDictionary *dicForImage;
@property (assign, nonatomic) BOOL couldLoadImage;

@end
