//
//  CartViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/1/22.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "CartViewController.h"
#import "Masonry.h"
#import "SLCartTableCell.h"
#import "AppDelegate.h"

#define TAG_BACKGROUNDVIEW 100
#define Botton_View_Tag  101

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width


@interface CartViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *myTableView;
    UIButton *selectAll;       //全选按钮
    BOOL isSelect;
    
    NSMutableArray *selectGoods;    //已选的商品集合
    UILabel *priceLabel;
    
    AppDelegate *delegate;
    double numberOfmoneyNeedToPay;
}


@end

@implementation CartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title = @"购物车";
    delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    numberOfmoneyNeedToPay = 0;
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20 + 44)];
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"购物车"];
    [self.view addSubview:navBar];
    [navBar pushNavigationItem:navItem animated:NO];
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:248/255.0 alpha:1];
    
    selectGoods = [[NSMutableArray alloc] init];      //初始化被选中的物品的数组
    [self setupMainView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    //判断购物车是否应该显示数据
    [self setupMainView];
    
    //每次进入购物车的时候把已选择的置空
    [selectGoods removeAllObjects];
    isSelect = NO;
    
    //全选按钮置未选择
    selectAll.selected = NO;
    [self countPrice];        //重置总价
    [self reloadTable];       //重置table view 数据
}


//计算已选中商品金额
-(void)countPrice
{
    double totlePrice = 0.0;
    for (SLGoodsDetail *model in selectGoods)
    {
        double price = [model.price doubleValue];
        totlePrice += price * model.countOfNeed;
    }
    
    numberOfmoneyNeedToPay = totlePrice;
    priceLabel.text = [NSString stringWithFormat:@"￥%.2f",totlePrice];
}


#pragma mark -- 设置主视图     分有资源 和 无资源两种情况
- (void)setupMainView
{
    //当购物车为空时，显示默认视图
    if (delegate.arrayForCart.count == 0)                     
    {
        UIView *bottonView = [self.view viewWithTag:Botton_View_Tag];
        if (bottonView != nil)
        {
            bottonView.hidden = YES;
        }
        
        UIView *vi = [self.view viewWithTag:TAG_BACKGROUNDVIEW];  //判断是否存在“啥都没有”，有就新增
        if (vi != nil)
        {
            return ;
        }
        
        [self cartEmptyShow];
    }
    //当购物车不为空时，tableView展示
    else
    {
        UIView *bottonView = [self.view viewWithTag:Botton_View_Tag];
        if (bottonView != nil)
        {
            bottonView.hidden = NO;
        }
        
        UIView *vi = [self.view viewWithTag:TAG_BACKGROUNDVIEW];
        [vi removeFromSuperview];           //这样移除真的好吗
        
        if (myTableView != nil)
        {
            return ;
        }else
        {
            myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20 + 44, SCREEN_WIDTH, SCREEN_HEIGHT - 50 - 49) style:UITableViewStylePlain];
            myTableView.delegate = self;
            myTableView.dataSource = self;
            myTableView.rowHeight = 100;
            myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            myTableView.backgroundColor = RGBCOLOR(245, 246, 248);
            
            [self.view addSubview:myTableView];
            
            [self setupBottomView];
        }
    }
}

//购物车为空时的默认视图
- (void)cartEmptyShow
{
    //默认视图背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    backgroundView.tag = TAG_BACKGROUNDVIEW;
    [self.view addSubview:backgroundView];
    
    //默认图片
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cart_default_bg"]];
    img.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 - 120);
    img.bounds = CGRectMake(0, 0, 247.0/187 * 100, 100);
    [backgroundView addSubview:img];
    
    //添加购物车为空时候的提示信息
    UILabel *warnLabel = [[UILabel alloc]init];
    warnLabel.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 - 10);
    warnLabel.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.text = @"购物车啥都没有";
    warnLabel.font = [UIFont systemFontOfSize:15];
    warnLabel.textColor = kUIColorFromRGB(0x706F6F);
    [backgroundView addSubview:warnLabel];
    
    //默认视图按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 + 40);
    btn.bounds = CGRectMake(0, 0, SCREEN_WIDTH - 40, 40);
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"去首页" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goToMainmenuView) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];            //没想好怎样跳转，先不加这个按钮
}

//购物车为空的时候去首页购物的按钮
-(void)goToMainmenuView
{
    //NSLog(@"去首页");
    self.tabBarController.selectedIndex = 0;     //手动在tabBarController 控制的视图控制器之间跳转
}

#pragma mark -- 设置有商品时的底部视图
- (void)setupBottomView
{
    //底部视图的背景
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50 - 49, SCREEN_WIDTH, 50)];
    bgView.tag = Botton_View_Tag;
    [self.view addSubview:bgView];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor = kUIColorFromRGB(0xD5D5D5);
    [bgView addSubview:line];
    
    //全选按钮
    selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = [UIFont systemFontOfSize:15];
    [selectAll setTitle:@" 全选" forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"cart_selected_btn"] forState:UIControlStateSelected];
    [selectAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:selectAll];
    
    //合计
    UILabel *label = [[UILabel alloc]init];
    label.text = @"合计: ";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:label];
    
    //价格
    priceLabel = [[UILabel alloc]init];
    priceLabel.text = @"￥0.00";
    priceLabel.font = [UIFont boldSystemFontOfSize:16];
    priceLabel.textColor = BASECOLOR_RED;
    [bgView addSubview:priceLabel];
    
    //结算按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = BASECOLOR_RED;
    [btn setTitle:@"去结算" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goPayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
//底部视图添加约束
    //全选按钮
    [selectAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(10);
        make.top.equalTo(@10);
        make.bottom.equalTo(bgView).offset(-10);
        make.width.equalTo(@60);
        
    }];
    
    //结算按钮
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView);
        make.right.equalTo(bgView);
        make.bottom.equalTo(bgView);
        make.width.equalTo(@100);
        
    }];
    
    //价格显示
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn.mas_left).offset(-10);
        make.top.equalTo(bgView).offset(10);
        make.bottom.equalTo(bgView).offset(-10);
        make.left.equalTo(label.mas_right);
    }];
    
    //合计
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(10);
        make.bottom.equalTo(bgView).offset(-10);
        make.right.equalTo(priceLabel.mas_left);
        make.width.equalTo(@60);
    }];
    
}


#pragma mark -- 全选按钮事件 和 提交订单按钮事件
-(void)selectAllBtnClick:(UIButton*)button      //全选按钮事件
{
    //点击全选时，把之前已选择的全部删除
    [selectGoods removeAllObjects];
    
    button.selected = !button.selected;
    isSelect = button.selected;
    if (isSelect)
    {
        for (SLGoodsDetail *model in delegate.arrayForCart)
        {
            [selectGoods addObject:model];
        }
    }
    else
    {
        [selectGoods removeAllObjects];
    }
    
    [myTableView reloadData];
    [self countPrice];
}

- (void)goPayBtnClick         //提交订单按钮事件  待写...
{
    if (numberOfmoneyNeedToPay == 0.0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"请至少选择一件购物车里面的商品再进行付款" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"支付功能正在开发中，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好吧" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


#pragma mark -- UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return delegate.arrayForCart.count;              //这个待会也要改的
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"cellID_%ld",(long)indexPath.row];
    SLCartTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[SLCartTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.isSelected = isSelect;      //这个对全选有很大作用
    
    //是否被选中
    if ([selectGoods containsObject:[delegate.arrayForCart objectAtIndex:indexPath.row]])
    {
        cell.isSelected = YES;
    }
    
    //选择回调
    cell.cartSelectBlock = ^(BOOL isSelec)        //点击cell中的是否选中的时候
    {
        if (isSelec)
        {
            [selectGoods addObject:[delegate.arrayForCart objectAtIndex:indexPath.row]];
        }
        else
        {
            [selectGoods removeObject:[delegate.arrayForCart objectAtIndex:indexPath.row]];
        }
        
        if (selectGoods.count == delegate.arrayForCart.count)      //判断如果用户自己一个一个都选了的话，全选按钮高亮
        {
            selectAll.selected = YES;
        }
        else
        {
            selectAll.selected = NO;
        }
        
        [self countPrice];            //重新计算价格
    };
    
    __block SLCartTableCell *wealCell = cell;
    cell.countAddBlock = ^()                            //增加数量的时候
    {
        NSInteger count = [wealCell.numberLabel.text integerValue];
        count++;
        NSString *numStr = [NSString stringWithFormat:@"%ld",(long)count];
        
        SLGoodsDetail *model = [delegate.arrayForCart objectAtIndex:indexPath.row];
        wealCell.numberLabel.text = numStr;
        model.countOfNeed = (int)count;
        
        //做一些善后操作
        [delegate.arrayForCart replaceObjectAtIndex:indexPath.row withObject:model];
        if ([selectGoods containsObject:model])
        {
            [self countPrice];
        }
    };
    
    cell.countCutBlock = ^()
    {
        NSInteger count = [wealCell.numberLabel.text integerValue];
        count --;
        if (count <= 0)
        {
            return ;
        }
        NSString *numStr = [NSString stringWithFormat:@"%ld",(long)count];
        wealCell.numberLabel.text = numStr;
        
        SLGoodsDetail *model = [delegate.arrayForCart objectAtIndex:indexPath.row];
        model.countOfNeed = (int)count;
        [delegate.arrayForCart replaceObjectAtIndex:indexPath.row withObject:model];
        
        //判断已选择数组里面有无该对象，有就刷新数据，
        if ([selectGoods containsObject:model])
        {
            [self countPrice];
        }
        
    };
    
    [cell reloadDataWith:[delegate.arrayForCart objectAtIndex:indexPath.row]];
    
    
    return cell;
}

-(void)reloadTable
{
    [myTableView reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
        {
            if ([selectGoods containsObject:[delegate.arrayForCart objectAtIndex:indexPath.row]])
            {
                [selectGoods removeObject:[delegate.arrayForCart objectAtIndex:indexPath.row]];
                [self countPrice];
            }
            [delegate.arrayForCart removeObjectAtIndex:indexPath.row];
            //[self didVIShouldShow];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            //延迟0.5s刷新一下,否则数据会乱
            [self performSelector:@selector(reloadTable) withObject:nil afterDelay:0.5];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)didVIShouldShow          //判断是不是没东西了     暂时没用到这个
{
    if (delegate.arrayForCart.count == 0)
    {
        UIView *vi = [self.view viewWithTag:TAG_BACKGROUNDVIEW];
        vi.hidden = NO;
    }
}

@end
