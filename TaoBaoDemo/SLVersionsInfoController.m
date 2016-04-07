//
//  SLVersionsInfoController.m
//  TaoBaoDemo
//
//  Created by fang on 16/4/6.
//  Copyright © 2016年 sl. All rights reserved.
//

#import "SLVersionsInfoController.h"
#import <SVProgressHUD.h>
#import <AVFoundation/AVFoundation.h>

@interface SLVersionsInfoController ()

@end

@implementation SLVersionsInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self speakSomeWords];
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

- (IBAction)newVersionsAction:(UIButton *)sender
{
    [SVProgressHUD showWithStatus:@"正在检测新版本，请稍后"];
    
    NSString *strURL = @"http://42.96.178.214/php/versions.php";
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if (error)
        {
            //NSLog(@"检查新版本失败");
            _strResult = @"3";
        }
        else
        {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            _strResult = array[0];
        }
    }];
    
    [dataTask resume];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(showVersionsResultFromServer:) userInfo:nil repeats:YES];
}

- (void)speakSomeWords
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"当前软件版本 1.0.0，制作者：天之行"];
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_TW"];
    utterance.voice = voice;
    utterance.volume = 1.0;
    utterance.rate = 0.45;       //设置语速
    //utterance.pitchMultiplier = 1.1;
    //NSLog(@"%@",[AVSpeechSynthesisVoice speechVoices]);
    AVSpeechSynthesizer *synth = [[AVSpeechSynthesizer alloc] init];
    [synth speakUtterance:utterance];
}

- (void)showVersionsResultFromServer:(NSTimer *)timer
{
    if (_strResult.length != 0)
    {
        [timer invalidate];
        
        if ([_strResult isEqualToString:@"0"])
        {
            [SVProgressHUD showSuccessWithStatus:@"已是最新版本"];
            [SVProgressHUD dismissWithDelay:2];
        }
        else if([_strResult isEqualToString:@"1"])
        {
            //[SVProgressHUD showSuccessWithStatus:@"检测到新版本"];
            [SVProgressHUD dismiss];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"紧急提示" message:@"检测到有包含很厉害功能的新版本，是否下载？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"就不下载" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"赶紧下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
            {
                //这里可以进行同下载相关的时间
                NSLog(@"正在下载中...");
                [NSThread sleepForTimeInterval:3];
                NSLog(@"检测到您当前网速过慢，下载完成估计需要100年，请稍等...");
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_strResult isEqualToString:@"3"])
        {
            [SVProgressHUD showErrorWithStatus:@"检测新版本失败"];
            [SVProgressHUD dismissWithDelay:2];
        }
    }
}



@end
