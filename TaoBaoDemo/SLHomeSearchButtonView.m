//
//  SLHomeSearchButtonView.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/26.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLHomeSearchButtonView.h"

@implementation SLHomeSearchButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIButton *buttonSearch = [[UIButton alloc] initWithFrame:frame];
        [buttonSearch addTarget:self action:@selector(buttonSearchAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonSearch];                 //添加搜索按钮
        
        
        UIImageView *imageViewSearch = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 15, 15)];
        imageViewSearch.image = [UIImage imageNamed:@"search_button.png"];
        [self addSubview:imageViewSearch];                    //添加搜索图标
        
        _labelMessage = [[UILabel alloc] initWithFrame:CGRectMake(10 + 15, 15, frame.size.width - 25, 15)];
        _labelMessage.text = @"玩漂移神器";
        _labelMessage.font = [UIFont systemFontOfSize:15.0];
        _labelMessage.textColor = [UIColor grayColor];
        [self addSubview:_labelMessage];                         //添加简单的信息广告文本框
        
        UIButton *buttonCamera = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 15 - 10, 15, 15, 15)];
        [buttonCamera setImage:[UIImage imageNamed:@"camera_button.png"] forState:UIControlStateNormal];
        [buttonCamera addTarget:self action:@selector(buttonCameraAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonCamera];                  //添加照相机图标
        
//添加线条优化
        UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 8 - 1, frame.size.width, 1)];
        line0.backgroundColor = [UIColor whiteColor];
        [self addSubview:line0];                      //添加最底下的横线
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 8 - 1 - 4, 1, 4)];
        line1.backgroundColor = [UIColor whiteColor];
        [self addSubview:line1];                       //添加左边的竖线
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - 1, frame.size.height - 8 - 1 - 4, 1, 4)];
        line2.backgroundColor = [UIColor whiteColor];
        [self addSubview:line2];                        //添加右边的竖线
        
        
    }
    
    
    return self;
}

- (void)buttonSearchAction:(UIButton *)sender
{
    //NSLog(@"这个是搜索按钮");
    if (self.searchButtonBlock)
    {
        self.searchButtonBlock();
    }
}

- (void)buttonCameraAction:(UIButton *)sender
{
    //NSLog(@"这个是相机按钮");
    if (self.cameraButtonBlock)
    {
        self.cameraButtonBlock();
    }
}






@end
