//
//  SLBuyNumberView.h
//  TaoBaoDemo
//
//  Created by fang on 16/3/29.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLBuyNumberView : UIView


@property (nonatomic, strong) UILabel *labelCount;

@property (nonatomic, copy) void(^buyBlockTest)(NSString *strNum);

@end
