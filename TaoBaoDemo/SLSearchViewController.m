//
//  SLSearchViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/4/4.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLSearchViewController.h"
#import "AppDelegate.h"
#import "SLBuyViewController.h"

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height

@interface SLSearchViewController ()

@end

@implementation SLSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"搜索";
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _mutArrayGoodsOriginal = [[NSMutableArray alloc] init];
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
//添加返回按钮
    UIButton *viewBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [viewBack setTitle:@"返回" forState:UIControlStateNormal];
    [viewBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [viewBack addTarget:self action:@selector(viewBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:viewBack];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
//初始化table view
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//初始化Search Bar
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, WL, 44)];
    self.searchBar.showsCancelButton = YES;
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    
//获取整个商品目录
    [self getAllGoodsInfoFromServer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- some action
- (void)viewBackAction          //返回上一视图
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)getAllGoodsInfoFromServer         //从服务器获取所有的商品信息
{
    NSString *strURL = @"http://42.96.178.214/php/queryA.php";          //待会记得放到服务器上面去
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error)
        {
            NSLog(@"请求失败，估计是网络问题");
        }
        else
        {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSMutableArray *mutArrayNumber = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in array)
            {
                [_mutArrayGoodsOriginal addObject:[dic objectForKey:@"name"]];
                [mutArrayNumber addObject:[dic objectForKey:@"number"]];
            }
            
            _mutArrayGoodsCopy = [_mutArrayGoodsOriginal mutableCopy];
            _dicGoodsInfo = [[NSDictionary alloc] initWithObjects:[mutArrayNumber copy] forKeys:[_mutArrayGoodsOriginal copy]];
            
            //[self.tableView reloadData];   //不要在block 回调里面刷新table view
        }
    }];
    
    [dataTask resume];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reloadTableView:) userInfo:nil repeats:YES];
}

- (void)reloadTableView:(NSTimer *)timer
{
    if (_dicGoodsInfo)
    {
        [self.tableView reloadData];
        [timer invalidate];
    }
}


#pragma mark -- table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dicGoodsInfo)
    {
        return _mutArrayGoodsCopy.count;
    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    //cell.textLabel.text = @"我是商品";
    
    if (_dicGoodsInfo)
    {
        cell.textLabel.text = [_mutArrayGoodsCopy objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"goods_%@.jpg",[_dicGoodsInfo objectForKey:[_mutArrayGoodsCopy objectAtIndex:indexPath.row]]]];
    }
    
    return cell;
}


#pragma mark -- table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strNumber = [_dicGoodsInfo objectForKey:[_mutArrayGoodsCopy objectAtIndex:indexPath.row]];
    delegate.numberOfGoods = strNumber.intValue;
    
    SLBuyViewController *buyController = [[SLBuyViewController alloc] init];
    [self presentViewController:buyController animated:YES completion:nil];
}


#pragma mark -- UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //NSLog(@"这个是cancel 按钮！");
    
    _searchBar.text = nil;
    [self.view endEditing:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //NSLog(@"文本框发生变化了");
    
    [_mutArrayGoodsCopy removeAllObjects];
    for (int i = 0; i < _mutArrayGoodsOriginal.count; i ++)
    {
        if ([_mutArrayGoodsOriginal[i] containsString:searchText])
        {
            [_mutArrayGoodsCopy addObject:_mutArrayGoodsOriginal[i]];
        }
    }
    
    if (searchText.length == 0)
    {
        for (int i = 0; i < _mutArrayGoodsOriginal.count; i ++)
        {
            [_mutArrayGoodsCopy addObject:_mutArrayGoodsOriginal[i]];
        }
    }
    
    //NSLog(@"遍历完成");
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}


@end
