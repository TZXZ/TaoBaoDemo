//
//  ASINetWorkQueue_imageDataDownLoadDemoViewController.m
//  ASINetWorkQueue_imageDataDownLoadDemo
//
//  Created by zhang heng on 11-5-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// http://www.fishjava.com/img/4a0575fc/1a988e79469680d572368.jpg 15kb
// http://www.mqq.me/attachments/2010/03/14/32_2010031410312717Nw1.jpg 7kb
// http://pic2.2389.com/sImgImage6/871/15784.jpg 14kb

#import "ASINetWorkQueue_imageDataDownLoadDemoViewController.h"
#import "ASIHTTPRequest.h"

// Private stuff
@interface ASINetWorkQueue_imageDataDownLoadDemoViewController ()
- (void)imageFetchComplete:(ASIHTTPRequest *)request;
- (void)imageFetchFailed:(ASIHTTPRequest *)request;
@end

@implementation ASINetWorkQueue_imageDataDownLoadDemoViewController

@synthesize imageviw_1;
@synthesize imageviw_2;
@synthesize imageviw_3;
//@synthesize sizeLab_1;
//@synthesize sizeLab_2;
//@synthesize sizeLab_3;
@synthesize progressView;
@synthesize progressViewImage_1;
@synthesize progressViewImage_2;
@synthesize progressViewImage_3;
@synthesize networkQueue;

#pragma mark 
#pragma mark implemeent Customer method
-(IBAction)PressButtonGoDownLoadImageData:(id)sender{
//	[self setImageviw_1:nil];
//	[self setImageviw_2:nil];
//	[self setImageviw_3:nil];
	
	if (!networkQueue) {
		networkQueue = [[ASINetworkQueue alloc] init];
	}
	failed = NO;
#pragma mark self;
#pragma mark reset Nwtwork object 
    
    [networkQueue reset];
    [networkQueue setDownloadProgressDelegate:progressView];
    [networkQueue setRequestDidFinishSelector:@selector(imageFetchComplete:)];
    [networkQueue setRequestDidFailSelector:@selector(imageFetchFailed:)];
    [networkQueue setDelegate:self];
    
    ASIHTTPRequest *request;
    request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.fishjava.com/img/4a0575fc/1a988e79469680d572368.jpg"]]autorelease];
    [request setDownloadDestinationPath:[[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"1.png"]];
    [request setDownloadProgressDelegate:progressViewImage_1];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"request1" forKey:@"name"]];
    [networkQueue addOperation:request];
    
    request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.mqq.me/attachments/2010/03/14/32_2010031410312717Nw1.jpg"]]autorelease];
    [request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"2.png"]];
    [request setDownloadProgressDelegate:progressViewImage_2];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"request2" forKey:@"name"]];
    [networkQueue addOperation:request];
    
    request  = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://pic2.2389.com/sImgImage6/871/15784.jpg"]]autorelease];
    [request setDownloadDestinationPath:[[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"3.png"]];
    [request setDownloadProgressDelegate:progressViewImage_3];
    [request setUserInfo:[NSDictionary dictionaryWithObject:@"request3" forKey:@"name"]];
    [networkQueue addOperation:request];

    NSLog(@"[NSHomeDirectory()stringByAppendingPathComponent:%@",[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"]);
    [networkQueue go];
}

- (void)imageFetchComplete:(ASIHTTPRequest *)request{
   // NSString *utl = @"/Users/zhangheng/Library/Application Support/iPhone Simulator/4.3/Applications/94AE7156-EA0C-49FC-BE4D-E41CFFACB6DF/Documents/3.png";
    UIImage *img = [UIImage imageWithContentsOfFile:[request downloadDestinationPath]];
    NSLog(@"\n\n[request downloadDestinationPath] =\n\n %@\n\n",[request downloadDestinationPath]);
    if (img) {
//                [imageviw_1 setImage:[UIImage imageNamed:@"3.png"]];
//                [imageviw_2 setImage:[UIImage imageNamed:@"3.png"]];
//                [imageviw_3 setImage:[UIImage imageNamed:@"3.png"]];
        NSLog(@"image not null");
        if ([imageviw_2 image]) {
                    NSLog(@"imageviw_1 not null");
            if ([imageviw_3 image]) {
                        NSLog(@"imageviw_2 not null");
                [imageviw_1 setImage:img];
            }else{
                NSLog(@"imageviw_2  null");
                [imageviw_3 setImage:img];
            }
        }else{
            NSLog(@"imageviw_1  null");
            [imageviw_2 setImage:img];
             NSLog(@"imageviw_1  null 00000000000000000");
        }
    }
}

- (void)imageFetchFailed:(ASIHTTPRequest *)request{
    if (!failed) {
        if([[request error] domain] !=NetworkRequestErrorDomain || [[request error]code] !=ASIRequestCancelledErrorType) {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"DownLoad Failed" message:@"DownLoad image failed" delegate:nil cancelButtonTitle:@"ok"otherButtonTitles:nil] autorelease];
            [alert show];
        }
        failed = YES;
    }
}

- (void)dealloc {
    [progressView release];
    [networkQueue reset];
    [networkQueue release];
    [super dealloc];
}

@end
