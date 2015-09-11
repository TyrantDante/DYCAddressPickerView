//
//  DYCAddress.h
//  DYCPickView
//
//  Created by DYC on 15/9/10.
//  Copyright (c) 2015年 DYC. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DYCAddressDelegate<NSObject>
@optional
-(void)addressList:(NSArray *)array;
@end
@interface DYCAddress : NSObject
@property (assign,nonatomic) id<DYCAddressDelegate> dataDelegate;
-(BOOL)handlerAddress;
@end
