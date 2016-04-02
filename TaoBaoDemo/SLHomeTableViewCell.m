//
//  SLHomeTableViewCell.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/22.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLHomeTableViewCell.h"
#import "AppDelegate.h"

#define WL self.frame.size.width

@implementation SLHomeTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark -- Action I
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier       //构造方法，在初始化对象的时候会调用
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.imageViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(self.widthLength / 2 - 40, 5, 20, 20)];
        self.imageViewHead.image = [UIImage imageNamed:@"discount_icon.png"];
        [self.contentView addSubview:self.imageViewHead];         //添加顶部标签图
        self.labelHead = [[UILabel alloc] initWithFrame:CGRectMake(self.widthLength / 2 - 10, 5, 60, 20)];
        self.labelHead.font = [UIFont systemFontOfSize:13.0];
        self.labelHead.textColor = [UIColor colorWithRed:200/255.0 green:65/255.0 blue:0/255.0 alpha:1];
        self.labelHead.text = @"超实惠";
        [self.contentView addSubview:self.labelHead];
        
        //让自定义的cell和系统的cell一样,一出来就拥有一些子控件提供给我们使用
        _button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0 + 30, 120, 90)];
        _label1_1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 90, 20)];
        _label1_2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 130, 20)];
        _label1_1.font = [UIFont systemFontOfSize:15.0];
        _label1_2.font = [UIFont systemFontOfSize:13.0];
        _label1_2.textColor = [UIColor grayColor];
        _label1_1.text = @"非常大牌";
        _label1_2.text = @"早春新品";
        [_button1 addSubview:_label1_1];
        [_button1 addSubview:_label1_2];
        [_button1 addTarget:self action:@selector(tenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button1];                  //第一个button
        
        _button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 90 + 30, 120, 90)];
        _label2_1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 90, 20)];
        _label2_2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 130, 20)];
        _label2_1.font = [UIFont systemFontOfSize:15.0];
        _label2_2.font = [UIFont systemFontOfSize:13.0];
        _label2_2.textColor = [UIColor grayColor];
        _label2_1.text = @"天天特价";
        _label2_2.text = @"每日精选千款好货";
        [_button2 addSubview:_label2_1];
        [_button2 addSubview:_label2_2];
        [_button2 addTarget:self action:@selector(tenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button2];
        
        int lengthW = (self.widthLength - 120) / 3;
        
        //上三个button
        _button3 = [[UIButton alloc] initWithFrame:CGRectMake(120, 0 + 30, lengthW, 90)];
        _label3_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, lengthW - 10, 20)];
        _label3_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, lengthW - 10, 20)];
        _label3_1.font = [UIFont systemFontOfSize:13.0];
        _label3_2.font = [UIFont systemFontOfSize:11.0];
        _label3_2.textColor = [UIColor grayColor];
        _label3_1.text = @"全球精选";
        _label3_2.text = @"抄底价包邮";
        [_button3 addSubview:_label3_1];
        [_button3 addSubview:_label3_2];
        [_button3 addTarget:self action:@selector(tenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button3];
        
        _button4 = [[UIButton alloc] initWithFrame:CGRectMake(120 + lengthW, 0 + 30, lengthW, 90)];
        _label4_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, lengthW - 10, 20)];
        _label4_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, lengthW - 10, 20)];
        _label4_1.font = [UIFont systemFontOfSize:13.0];
        _label4_2.font = [UIFont systemFontOfSize:11.0];
        _label4_2.textColor = [UIColor grayColor];
        _label4_1.text = @"量贩团";
        _label4_2.text = @"价优赠品多";
        [_button4 addSubview:_label4_1];
        [_button4 addSubview:_label4_2];
        [_button4 addTarget:self action:@selector(tenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button4];
        
        _button5 = [[UIButton alloc] initWithFrame:CGRectMake(120 + lengthW * 2, 0 + 30, lengthW, 90)];
        _label5_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, lengthW - 10, 20)];
        _label5_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, lengthW - 10, 20)];
        _label5_1.font = [UIFont systemFontOfSize:13.0];
        _label5_2.font = [UIFont systemFontOfSize:11.0];
        _label5_2.textColor = [UIColor grayColor];
        _label5_1.text = @"聚名品";
        _label5_2.text = @"无奢不欢";
        [_button5 addSubview:_label5_1];
        [_button5 addSubview:_label5_2];
        [_button5 addTarget:self action:@selector(tenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button5];
        
        //下三个button
        _button6 = [[UIButton alloc] initWithFrame:CGRectMake(120, 90 + 30, lengthW, 90)];
        _label6_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, lengthW - 10, 20)];
        _label6_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, lengthW - 10, 20)];
        _label6_1.font = [UIFont systemFontOfSize:13.0];
        _label6_2.font = [UIFont systemFontOfSize:11.0];
        _label6_2.textColor = [UIColor grayColor];
        _label6_1.text = @"品牌店庆";
        _label6_2.text = @"立减10元";
        [_button6 addSubview:_label6_1];
        [_button6 addSubview:_label6_2];
        [_button6 addTarget:self action:@selector(tenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button6];
        
        _button7 = [[UIButton alloc] initWithFrame:CGRectMake(120 + lengthW, 90 + 30, lengthW, 90)];
        _label7_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, lengthW - 10, 20)];
        _label7_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, lengthW - 10, 20)];
        _label7_1.font = [UIFont systemFontOfSize:13.0];
        _label7_2.font = [UIFont systemFontOfSize:11.0];
        _label7_2.textColor = [UIColor grayColor];
        _label7_1.text = @"俪人购";
        _label7_2.text = @"满500减100";
        [_button7 addSubview:_label7_1];
        [_button7 addSubview:_label7_2];
        [_button7 addTarget:self action:@selector(tenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button7];
        
        _button8 = [[UIButton alloc] initWithFrame:CGRectMake(120 + lengthW * 2, 90 + 30, lengthW, 90)];
        _label8_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, lengthW - 10, 20)];
        _label8_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, lengthW - 10, 20)];
        _label8_1.font = [UIFont systemFontOfSize:13.0];
        _label8_2.font = [UIFont systemFontOfSize:11.0];
        _label8_2.textColor = [UIColor grayColor];
        _label8_1.text = @"清仓";
        _label8_2.text = @"品牌尾货清";
        [_button8 addSubview:_label8_1];
        [_button8 addSubview:_label8_2];
        [_button8 addTarget:self action:@selector(tenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button8];
        
        //添加线条优化效果
        UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(0, 30, self.widthLength - 0.5, 0.5)];
        line0.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self.contentView addSubview:line0];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 89.5 + 30, self.widthLength, 0.5)];
        line1.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self.contentView addSubview:line1];
        //中间横线
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(119.5, 0 + 30, 0.5, 180)];
        line2.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self.contentView addSubview:line2];
        //第一条竖线
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(119.5 + lengthW, 0 + 30, 0.5, 180)];
        line3.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self.contentView addSubview:line3];
        
        UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(119.5 + lengthW * 2, 0 + 30, 0.5, 180)];
        line4.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self.contentView addSubview:line4];
    }
    
    return self;
}


- (void)tenButtonAction:(UIButton *)sender
{
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if ([self.reuseIdentifier isEqualToString:@"SectionZero"])
    {
        //NSLog(@"这个是Section0的button");
        if (sender == _button1)
        {
            //NSLog(@"这个是button1");
            appDelegate.numberOfGoods = 10005;
        }
        else if (sender == _button2)
        {
            //NSLog(@"这个是button2");
            appDelegate.numberOfGoods = 10006;
        }
        else if (sender == _button3)
        {
            //NSLog(@"这个是nutton3");
            appDelegate.numberOfGoods = 10007;
        }
        else if (sender == _button4)
        {
            //NSLog(@"这个是nutton4");
            appDelegate.numberOfGoods = 10008;
        }
        else if (sender == _button5)
        {
            //NSLog(@"这个是nutton5");
            appDelegate.numberOfGoods = 10009;
        }
        else if (sender == _button6)
        {
            //NSLog(@"这个是nutton6");
            appDelegate.numberOfGoods = 10010;
        }
        else if (sender == _button7)
        {
            //NSLog(@"这个是nutton7");
            appDelegate.numberOfGoods = 10011;
        }
        else if (sender == _button8)
        {
            //NSLog(@"这个是nutton8");
            appDelegate.numberOfGoods = 10012;
        }
        
    }
    else if ([self.reuseIdentifier isEqualToString:@"SectionTwo"])
    {
        NSLog(@"这个是Section2的button");
        if (sender == _button1)
        {
            //NSLog(@"这个是button1");
            appDelegate.numberOfGoods = 10019;
        }
        else if (sender == _button2)
        {
            //NSLog(@"这个是button2");
            appDelegate.numberOfGoods = 10020;
        }
        else if (sender == _button3)
        {
            //NSLog(@"这个是nutton3");
            appDelegate.numberOfGoods = 10021;
        }
        else if (sender == _button4)
        {
            //NSLog(@"这个是nutton4");
            appDelegate.numberOfGoods = 10022;
        }
        else if (sender == _button5)
        {
            //NSLog(@"这个是nutton5");
            appDelegate.numberOfGoods = 10023;
        }
        else if (sender == _button6)
        {
            //NSLog(@"这个是nutton6");
            appDelegate.numberOfGoods = 10024;
        }
        else if (sender == _button7)
        {
            //NSLog(@"这个是nutton7");
            appDelegate.numberOfGoods = 10025;
        }
        else if (sender == _button8)
        {
            //NSLog(@"这个是nutton8");
            appDelegate.numberOfGoods = 10026;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(actWhenUserTouchThisCell)])
    {
        [self.delegate actWhenUserTouchThisCell];
    }
    
    if (self.ForSectionTwoCell)
    {
        self.ForSectionTwoCell();
    }
}





@end
