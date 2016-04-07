//
//  CommunityViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/1/22.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "CommunityViewController.h"
#import "SLCommunityViewCell.h"

@interface CommunityViewController ()

@end

@implementation CommunityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    UINib *nib = [UINib nibWithNibName:@"SLCommunityViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:cellID];
    SLCommunityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.imageHead.layer.cornerRadius = 14;
    cell.imageHead.layer.masksToBounds = YES;
    
    return cell;
}


#pragma mark -- table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 263.0;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


@end
