//
//  SLPayViewController.m
//  TaoBaoDemo
//
//  Created by fang on 16/3/31.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLPayViewController.h"

#define WL self.view.frame.size.width
#define HL self.view.frame.size.height

@interface SLPayViewController ()

@end

@implementation SLPayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen] bounds];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
