//
//  SLBuyNumberView.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/29.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLBuyNumberView.h"

@implementation SLBuyNumberView

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
        float tempW = frame.size.width;
        float tempH = frame.size.height;
        
//        UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tempW, 0.5)];
//        line0.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
//        [self addSubview:line0];           //添加最上面线条
        
        UILabel *labelType = [[UILabel alloc] initWithFrame:CGRectMake(0 + 10, 20, 60, 20)];
        labelType.font = [UIFont systemFontOfSize:12.0];
        labelType.text = @"套餐类型";
        [self addSubview:labelType];                //添加套餐类型文本框
        
        UIButton *buttonTest = [[UIButton alloc] initWithFrame:CGRectMake(0 + 10, 20 + 20 + 10, 60, 20)];
        buttonTest.backgroundColor = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:26/255.0 alpha:1];
        [buttonTest setTitle:@"官方标配" forState:UIControlStateNormal];
        buttonTest.titleLabel.textColor = [UIColor whiteColor];
        buttonTest.layer.cornerRadius = 6;
        buttonTest.layer.masksToBounds = YES;
        buttonTest.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:buttonTest];                    //添加官方标配按钮
        
        UILabel *labelCountTip = [[UILabel alloc] initWithFrame:CGRectMake(0 + 10, 20 + 20 + 10 + 20 + 10, 60, 20)];
        labelCountTip.text = @"购买数量";
        labelCountTip.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:labelCountTip];               //添加购买数量提示文本框
        
        UIButton *buttonReduceNumber = [[UIButton alloc] initWithFrame:CGRectMake(0 + 10 + 40 + 40 + 40, 20 + 20 + 10 + 20 + 10, 20, 20)];
        [buttonReduceNumber setImage:[UIImage imageNamed:@"reduce_number.png"] forState:UIControlStateNormal];
        [buttonReduceNumber addTarget:self action:@selector(reduceNumberAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonReduceNumber];                 //添加减少数量按钮
        
        _labelCount = [[UILabel alloc] initWithFrame:CGRectMake(0 + 10 + 40 + 40 + 40 + 20 + 16, 20 + 20 + 10 + 20 + 10, 40, 20)];
        _labelCount.text = @"1";
        _labelCount.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:_labelCount];                       //添加数量文本框
        
        UIButton *buttonAddNumber = [[UIButton alloc] initWithFrame:CGRectMake(0 + 10 + 40 + 40 + 40 + 20 + 40, 20 + 20 + 10 + 20 + 10, 20, 20)];
        [buttonAddNumber setImage:[UIImage imageNamed:@"add_number.png"] forState:UIControlStateNormal];
        [buttonAddNumber addTarget:self action:@selector(addNumberAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonAddNumber];                 //添加增加数量按钮
        
        UIButton *buttonOK = [[UIButton alloc] initWithFrame:CGRectMake(0, tempH - 40, tempW, 40)];
        buttonOK.backgroundColor = [UIColor colorWithRed:255/255.0 green:74/255.0 blue:26/255.0 alpha:1];
        [buttonOK setTitle:@"确定" forState:UIControlStateNormal];
        buttonOK.titleLabel.textColor = [UIColor whiteColor];
        [buttonOK addTarget:self action:@selector(buttonOK:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonOK];                  //添加确定按钮
        
        
        self.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];    //添加背景颜色
        
        
    }
    
    return self;
}


- (void)reduceNumberAction:(UIButton *)sender
{
    int numberTemp = [self.labelCount.text intValue];
    if (numberTemp == 1)
    {
        return ;
    }else
    {
        numberTemp -= 1;
        self.labelCount.text = [NSString stringWithFormat:@"%d",numberTemp];
    }
    
}

- (void)addNumberAction:(UIButton *)sender
{
    int numberTemp = [self.labelCount.text intValue];
    numberTemp += 1;
    self.labelCount.text = [NSString stringWithFormat:@"%d",numberTemp];
}

- (void)buttonOK:(UIButton *)sender
{
    if (self.buyBlockTest)
    {
        self.buyBlockTest(self.labelCount.text);
    }
}





@end
