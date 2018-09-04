//
//  CaptchaTimerManager.h
//  PNCMobileBank
//
//  Created by YLG on 2018/5/8.
//  Copyright © 2018年 YLG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaptchaTimerManager : NSObject
@property (nonatomic,assign)__block int timeout;
+ (id)sharedTimerManager;
- (void)countDown;
@end
