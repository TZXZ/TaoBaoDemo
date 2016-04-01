//
//  SLHomeSecondCell.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/25.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLHomeSecondCell.h"
#import "AppDelegate.h"


@implementation SLHomeSecondCell

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
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier     //构造方法，初始化时调用
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //让自定的cell和系统的cell一样，一出来就拥有一些子控件提供给我们使用
        self.imageViewHead = [[UIImageView alloc] initWithFrame:CGRectMake(self.widthLength / 2 - 40, 5, 20, 20)];
        self.imageViewHead.image = [UIImage imageNamed:@"tianmao_special.png"];
        [self.contentView addSubview:self.imageViewHead];         //添加顶部标签图
        self.labelHead = [[UILabel alloc] initWithFrame:CGRectMake(self.widthLength / 2 - 10, 5, 60, 20)];
        self.labelHead.font = [UIFont systemFontOfSize:13.0];
        self.labelHead.textColor = [UIColor colorWithRed:255/255.0 green:0 blue:0 alpha:1];
        self.labelHead.text = @"天猫精选";
        [self.contentView addSubview:self.labelHead];
        
        //初始化上面两个button
        float marginWidth1 = self.widthLength / 2;
        _button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0 + 30, marginWidth1, 90)];
        _label1_1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, marginWidth1, 20)];
        _label1_2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, marginWidth1, 20)];
        _label1_1.font = [UIFont systemFontOfSize:15.0];
        _label1_2.font = [UIFont systemFontOfSize:13.0];
        _label1_2.textColor = [UIColor grayColor];
        _label1_1.text = @"全球时尚";
        _label1_2.text = @"大牌精致时尚";
        [_button1 addSubview:_label1_1];
        [_button1 addSubview:_label1_2];
        [_button1 addTarget:self action:@selector(eightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button1];                          //添加第一个button
        
        _button2 = [[UIButton alloc] initWithFrame:CGRectMake(marginWidth1, 0 + 30, marginWidth1, 90)];
        _label2_1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, marginWidth1, 20)];
        _label2_2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, marginWidth1, 20)];
        _label2_1.font = [UIFont systemFontOfSize:15.0];
        _label2_2.font = [UIFont systemFontOfSize:13.0];
        _label2_2.textColor = [UIColor grayColor];
        _label2_1.text = @"品牌街";
        _label2_2.text = @"什么牌子好";
        [_button2 addSubview:_label2_1];
        [_button2 addSubview:_label2_2];
        [_button2 addTarget:self action:@selector(eightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button2];                          //添加第二个button
        
        //初始化下面四个button
        float marginWidth2 = self.widthLength / 4;
        _button3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 90 + 30, marginWidth2, 90)];
        _label3_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, marginWidth2 - 10, 20)];
        _label3_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, marginWidth2 - 10, 20)];
        _label3_1.font = [UIFont systemFontOfSize:13.0];
        _label3_2.font = [UIFont systemFontOfSize:11.0];
        _label3_2.textColor = [UIColor grayColor];
        _label3_1.text = @"天猫换新";
        _label3_2.text = @"品牌精选新品";
        [_button3 addSubview:_label3_1];
        [_button3 addSubview:_label3_2];
        [_button3 addTarget:self action:@selector(eightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button3];                     //添加第三个button
        
        _button4 = [[UIButton alloc] initWithFrame:CGRectMake(marginWidth2, 90 + 30, marginWidth2, 90)];
        _label4_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, marginWidth2 - 10, 20)];
        _label4_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, marginWidth2 - 10, 20)];
        _label4_1.font = [UIFont systemFontOfSize:13.0];
        _label4_2.font = [UIFont systemFontOfSize:11.0];
        _label4_2.textColor = [UIColor grayColor];
        _label4_1.text = @"天天搞机";
        _label4_2.text = @"红米今日原价";
        [_button4 addSubview:_label4_1];
        [_button4 addSubview:_label4_2];
        [_button4 addTarget:self action:@selector(eightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button4];                        //添加第四个button
        
        _button5 = [[UIButton alloc] initWithFrame:CGRectMake(marginWidth2 * 2, 90 + 30, marginWidth2, 90)];
        _label5_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, marginWidth2 - 10, 20)];
        _label5_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, marginWidth2 - 10, 20)];
        _label5_1.font = [UIFont systemFontOfSize:13.0];
        _label5_2.font = [UIFont systemFontOfSize:11.0];
        _label5_2.textColor = [UIColor grayColor];
        _label5_1.text = @"喵鲜生";
        _label5_2.text = @"好生鲜不用挑";
        [_button5 addSubview:_label5_1];
        [_button5 addSubview:_label5_2];
        [_button5 addTarget:self action:@selector(eightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button5];                        //添加第五个button
        
        _button6 = [[UIButton alloc] initWithFrame:CGRectMake(marginWidth2 * 3, 90 + 30, marginWidth2, 90)];
        _label6_1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, marginWidth2 - 10, 20)];
        _label6_2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, marginWidth2 - 10, 20)];
        _label6_1.font = [UIFont systemFontOfSize:13.0];
        _label6_2.font = [UIFont systemFontOfSize:11.0];
        _label6_2.textColor = [UIColor grayColor];
        _label6_1.text = @"苏宁易购";
        _label6_2.text = @"苹果6s低爆疯抢";
        [_button6 addSubview:_label6_1];
        [_button6 addSubview:_label6_2];
        [_button6 addTarget:self action:@selector(eightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button6];                        //添加第六个button
        
        //添加线条优化效果
        UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(0, 30, self.widthLength, 0.5)];
        line0.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self.contentView addSubview:line0];                 //第一条横线
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 30 + 90, self.widthLength, 0.5)];
        line1.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self.contentView addSubview:line1];                 //第二条横线
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(marginWidth2 - 0.5, 30 + 90, 0.5, 90)];
        line2.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self.contentView addSubview:line2];                 //第一条竖线
        
        UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(marginWidth2 * 2 - 0.5, 30, 0.5, 180)];
        line3.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self.contentView addSubview:line3];                 //第二条竖线
        
        UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(marginWidth2 * 3 - 0.5, 30 + 90, 0.5, 90)];
        line4.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:230/255.0 alpha:1];
        [self.contentView addSubview:line4];                 //第二条竖线
        
        
    }
    
    return self;
}


- (void)eightButtonAction:(UIButton *)sender
{
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //NSLog(@"这个是Section1 和Section3 的Button事件");
    if ([self.reuseIdentifier isEqualToString:@"SectionOne"])
    {
        if (sender == _button1)
        {
            delegate.numberOfGoods = 10013;
        }
        else if (sender == _button2)
        {
            delegate.numberOfGoods = 10014;
        }
        else if (sender == _button3)
        {
            delegate.numberOfGoods = 10015;
        }
        else if (sender == _button4)
        {
            delegate.numberOfGoods = 10016;
        }
        else if (sender == _button5)
        {
            delegate.numberOfGoods = 10017;
        }
        else if (sender == _button6)
        {
            delegate.numberOfGoods = 10018;
        }
    }
    else if ([self.reuseIdentifier isEqualToString:@"SectionThree"])
    {
        if (sender == _button1)
        {
            delegate.numberOfGoods = 10027;
        }
        else if (sender == _button2)
        {
            delegate.numberOfGoods = 10028;
        }
        else if (sender == _button3)
        {
            delegate.numberOfGoods = 10029;
        }
        else if (sender == _button4)
        {
            delegate.numberOfGoods = 10030;
        }
        else if (sender == _button5)
        {
            delegate.numberOfGoods = 10031;
        }
        else if (sender == _button6)
        {
            delegate.numberOfGoods = 10032;
        }
    }
    
    
    if (self.SecondCellBlock)
    {
        self.SecondCellBlock();
    }
}


@end
