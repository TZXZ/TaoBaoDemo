//
//  MicroViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/1/22.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "MicroViewController.h"
#import "SLMicroViewCell.h"

@interface MicroViewController ()

@end

@implementation MicroViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//初始化table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UINib *nib = [UINib nibWithNibName:@"SLMicroViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellID];
    SLMicroViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    return cell;
}


#pragma mark -- table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 252.0;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


@end
