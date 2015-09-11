//
//  Address.h
//  DYCPickView
//
//  Created by DYC on 15/9/10.
//  Copyright (c) 2015年 DYC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject
@property (assign,nonatomic) NSInteger areaId;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *indexChar;
@property (assign,nonatomic) NSInteger level;
@property (assign,nonatomic) NSInteger hot;
@property (assign,nonatomic) NSInteger commend;
@property (assign,nonatomic) NSInteger postCode;
@property (assign,nonatomic) NSInteger parentId;
@property (assign,nonatomic) NSInteger areaCode;
@property (assign,nonatomic) NSInteger fatherCode;
@property (strong,nonatomic) NSMutableArray *sonAddress;
 @end
