//
//  SLGoodsDetail.h
//  TaoBaoDemo
//
//  Created by fang on 16/3/28.
//  Copyright © 2016年 sl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLGoodsDetail : NSObject


@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *priceLow;
@property (nonatomic, copy) NSString *priceHigh;
@property (nonatomic, copy) NSString *describe;

@property (nonatomic, copy) NSString *imgAddress1;
@property (nonatomic, copy) NSString *imgAddress2;
@property (nonatomic, copy) NSString *imgAddress3;

@property (nonatomic, copy) NSString *postState;
@property (nonatomic, copy) NSString *saleState;
@property (nonatomic, copy) NSString *addressState;

@property (nonatomic, assign) int countOfNeed;
@property (nonatomic, copy) NSString *dateStr;

@end
