//
//  ASINetWorkQueue_imageDataDownLoadDemoViewController.h
//  ASINetWorkQueue_imageDataDownLoadDemo
//
//  Created by zhang heng on 11-5-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASINetworkQueue.h"

@interface ASINetWorkQueue_imageDataDownLoadDemoViewController : UIViewController {
	ASINetworkQueue *networkQueue;
	
	UIImageView *imageviw_1;
	UIImageView *imageviw_2;
	UIImageView *imageviw_3;
	
	
	UIProgressView *progressView;
	UIProgressView *progressViewImage_1;
	UIProgressView *progressViewImage_2;
	UIProgressView *progressViewImage_3;
	
	BOOL failed;
}

@property (nonatomic ,retain) IBOutlet 	UIImageView *imageviw_1;
@property (nonatomic ,retain) IBOutlet 	UIImageView *imageviw_2;
@property (nonatomic ,retain) IBOutlet 	UIImageView *imageviw_3;
//@property (nonatomic ,retain) IBOutlet   UILabel *sizeLab_1;
//@property (nonatomic ,retain) IBOutlet   UILabel *sizeLab_2;
//@property (nonatomic ,retain) IBOutlet   UILabel *sizeLab_3;
@property (nonatomic ,retain) IBOutlet   UIProgressView *progressView;
@property (nonatomic ,retain) IBOutlet   UIProgressView *progressViewImage_1;
@property (nonatomic ,retain) IBOutlet   UIProgressView *progressViewImage_2;
@property (nonatomic ,retain) IBOutlet   UIProgressView *progressViewImage_3;
@property (nonatomic ,retain ) 	ASINetworkQueue *networkQueue;
-(IBAction)PressButtonGoDownLoadImageData:(id)sender;

@end

