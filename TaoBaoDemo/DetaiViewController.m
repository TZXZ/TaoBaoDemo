//
//  DetaiViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/21.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "DetaiViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "SLVersionsInfoController.h"
#import "SLNameChangeController.h"

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height

@interface DetaiViewController ()

@end

@implementation DetaiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人信息";
    self.view.frame = [[UIScreen mainScreen] bounds];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加导航控制器上面的左侧返回button
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [leftButton setImage:[UIImage imageNamed:@"view_back.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(viewBackAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //初始化table view
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WL, HL - 80) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    //初始化退出当前用户的按钮
    UIButton *buttonUserLeft = [[UIButton alloc] initWithFrame:CGRectMake(20, HL - 60, WL - 40, 40)];
    buttonUserLeft.backgroundColor = [UIColor colorWithRed:255/255.0 green:132/255.0 blue:134/255.0 alpha:1];
    buttonUserLeft.layer.cornerRadius = 8.0;
    buttonUserLeft.layer.masksToBounds = YES;
    [buttonUserLeft setTitle:@"退出当前用户" forState:UIControlStateNormal];
    [buttonUserLeft addTarget:self action:@selector(buttonUserLeft) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonUserLeft];               //添加退出当前用户按钮
    
    //初始化第一个Cell里面的imageView
    self.imageViewForCell = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    self.imageViewForCell.layer.cornerRadius = 30.0;
    self.imageViewForCell.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


#pragma mark -- 一般按钮的事件写在这里
- (void)viewBackAction        //返回上一级视图按钮事件
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buttonUserLeft
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"你即将退出账户，是否确认？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        appDelegate.userHasLogin = NO;
        appDelegate.userInfomation = [[UserInfomation alloc] init];
        appDelegate.arrayForCart = [[NSMutableArray alloc] init];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark -- UITableViewDataSourece
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 2;
    }
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1)
    {
        static NSString *cellID1 = @"cellID1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID1];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = @"清除缓存";
                break;
                
            case 1:
                cell.textLabel.text = @"版本信息";
                cell.detailTextLabel.text = @"V 1.0.0";
                cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
                break;
                
            default:
                break;
        }
        
        return cell;
    }
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageName = [NSString stringWithFormat:@"%@.png",appDelegate.userInfomation.phone];
    NSString *filePath = [documentPath stringByAppendingPathComponent:imageName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    switch (indexPath.row)
    {
        case 0:
            [cell addSubview:self.imageViewForCell];
            self.imageViewForCell.image = [UIImage imageNamed:@"wei_bo.png"];
            cell.detailTextLabel.text = @"淘宝头像";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:17.0];

            if (appDelegate.userInfomation.imageName != nil || [fileManager fileExistsAtPath:filePath])
            {
                self.imageViewForCell.image = [UIImage imageWithContentsOfFile:filePath];
            }
            break;
            
        case 1:
            cell.textLabel.text = @"淘宝昵称";
            cell.detailTextLabel.text = appDelegate.userInfomation.name;
            break;
            
        case 2:
            cell.textLabel.text = @"密码";
            cell.detailTextLabel.text = @"修改密码";
            break;
            
        case 3:
            cell.textLabel.text = @"性别";
            cell.detailTextLabel.text = @"未设置";
            break;
            
        case 4:
            cell.textLabel.text = @"生日";
            cell.detailTextLabel.text = @"未填写";
            break;
            
        case 5:
            cell.textLabel.text = @"收货地址";
            cell.detailTextLabel.text = @"管理收货地址";
            break;

        default:
            break;
    }
    
    return cell;
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        return 44.0;
    }
    
    if (indexPath.row == 0)
    {
        return 80.0;
    }else
    {
        return 44.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.editing = YES;
        
        if (indexPath.row == 1)
        {
            SLNameChangeController *nameChangeController = [[SLNameChangeController alloc] init];
            [self.navigationController pushViewController:nameChangeController animated:YES];
        }
        
        
        switch (indexPath.row)
        {
            case 0:
                [self presentViewController:imagePickerController animated:YES completion:nil];
                break;
                
            case 2:
                NSLog(@"点击了密码");
                break;
                
            case 3:
                NSLog(@"性别");
                break;
                
            case 4:
                NSLog(@"生日");
                break;
                
            case 5:
                NSLog(@"收货地址");
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            //NSLog(@"这个是清除缓存");
            [SVProgressHUD show];
            
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^
                           {
                               //清除缓存
                               NSString *catch = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                               //NSLog(@"catch = %@",catch);          //沙盒里面缓存的文件路径
                               NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:catch];
                               fileCount = (int)[files count];
                               for (NSString *p in files)
                               {
                                   NSError *error;
                                   NSString *path = [catch stringByAppendingPathComponent:p];
                                   if ([[NSFileManager defaultManager] fileExistsAtPath:path])
                                   {
                                       [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                                   }
                               }
                           });
            
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(stopProgressAction:) userInfo:nil repeats:NO];
        }
        else if (indexPath.row == 1)
        {
            //NSLog(@"这个是版本信息");
            SLVersionsInfoController *versionsController = [[SLVersionsInfoController alloc] init];
            [self.navigationController pushViewController:versionsController animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
}


- (void)stopProgressAction:(NSTimer *)timer
{
    [timer invalidate];

    [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"成功清理了%d个文件",fileCount]];
    [SVProgressHUD dismissWithDelay:2];
}


#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo
{
    NSData *data;
    data = UIImagePNGRepresentation(image);
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"documentPath = %@",documentPath);
    NSString *imageName = [NSString stringWithFormat:@"%@.png",appDelegate.userInfomation.phone];
    NSString *filePath = [documentPath stringByAppendingPathComponent:imageName];
    [data writeToFile:filePath atomically:YES];
    appDelegate.userInfomation.imageName = imageName;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
