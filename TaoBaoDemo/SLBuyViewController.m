//
//  SLBuyViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/27.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLBuyViewController.h"

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height

@interface SLBuyViewController ()

@end

@implementation SLBuyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//初始化table view,其他的视图都是放在这个上面的
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, WL, HL - 20 - 60)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    
    
//初始化返回按钮
    UIButton *buttonViewBack = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];
    [buttonViewBack setImage:[UIImage imageNamed:@"buy_view_back.png"] forState:UIControlStateNormal];
    [buttonViewBack addTarget:self action:@selector(viewBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonViewBack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = @"我就是CELL";
    
    return cell;
}


#pragma mark -- TableViewDelegate





@end
