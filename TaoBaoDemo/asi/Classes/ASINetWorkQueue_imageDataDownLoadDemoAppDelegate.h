//
//  ASINetWorkQueue_imageDataDownLoadDemoAppDelegate.h
//  ASINetWorkQueue_imageDataDownLoadDemo
//
//  Created by zhang heng on 11-5-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASINetWorkQueue_imageDataDownLoadDemoViewController;

@interface ASINetWorkQueue_imageDataDownLoadDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ASINetWorkQueue_imageDataDownLoadDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ASINetWorkQueue_imageDataDownLoadDemoViewController *viewController;

@end

