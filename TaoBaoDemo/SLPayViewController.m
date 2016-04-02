//
//  SLPayViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/31.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLPayViewController.h"
#import "SLPayViewCell.h"

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height

@interface SLPayViewController ()

@end

@implementation SLPayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = NO;
    
    double priceNum = _goodsYouPayNow.price.doubleValue;
    double totalMoney = priceNum * _goodsYouPayNow.countOfNeed;
    _labelPayMoney.text = [NSString stringWithFormat:@"￥%.1f",totalMoney];
    _labelName.text = delegate.userInfomation.name;
    _labelPhone.text = delegate.userInfomation.phone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- IBAction
- (IBAction)viewBackAction:(UIBarButtonItem *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)payMoneyAction:(UIButton *)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"支付功能正在开发中，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好吧" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"cellID_%ld",(long)indexPath.row];
    
    if (indexPath.row == 1)
    {
        UINib *nib = [UINib nibWithNibName:@"SLPayViewCell" bundle:nil];
        [self.tableView registerNib:nib forCellReuseIdentifier:cellID];
        SLPayViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        cell.labelPrice.text = _goodsYouPayNow.price;
        cell.labelDescribe.text = _goodsYouPayNow.describe;
        cell.imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"goods_%@.jpg",_goodsYouPayNow.number]];
        cell.labelCount.text = [NSString stringWithFormat:@"X%d",_goodsYouPayNow.countOfNeed];
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    if (indexPath.row == 0)
    {
        cell.textLabel.text = _goodsYouPayNow.name;
        cell.imageView.image = [UIImage imageNamed:@"taobao_cell.png"];
    }
    else if (indexPath.row == 2)
    {
        cell.textLabel.text = @"购买数量";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",_goodsYouPayNow.countOfNeed];
    }
    else if (indexPath.row == 3)
    {
        cell.textLabel.text = @"配送方式";
        cell.detailTextLabel.text = @"快递 免邮";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.row == 4)
    {
        cell.textLabel.text = @"运费保险";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.row == 5)
    {
        cell.textLabel.text = @"买家留言：";
        float widthL = cell.frame.size.width;
        float heightL = cell.frame.size.height;
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(120, 0, widthL - 120, heightL)];
        textField.placeholder = @"选填：可以写特殊要求";
        textField.delegate = self;
        [cell.contentView addSubview:textField];
    }
    
    //cell.textLabel.text = @"I'm cell !";
    
    return cell;
}


#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        return 160;
    }
    else
    {
        return 44;
    }
}


#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [self.view endEditing:YES];
    
    return YES;
}


@end
