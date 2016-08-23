//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ContentAdLoadedListener;

@interface ServiceLoader : NSObject

@property (nonatomic, readwrite, strong) ContentAdLoadedListener* contentAdLoadedListener;

- (instancetype) initWithAdUnitID:(NSString*) adUnitID;

- (void) loadAd;
@end