//
//  SLHomeSearchButtonView.h
//  TaoBaoDemo
//
//  Created by fang on 16/3/26.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLHomeSearchButtonView : UIView

@property (nonatomic, strong) UILabel *labelMessage;
@property (nonatomic, copy) void (^cameraButtonBlock)();
@property (nonatomic, copy) void (^searchButtonBlock)();


@end
