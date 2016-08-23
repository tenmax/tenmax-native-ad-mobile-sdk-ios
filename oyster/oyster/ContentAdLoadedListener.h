//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdLoadedListener.h"

@class OysterAdLoader;
@protocol OysterContentAdLoaderDelegate;

@interface ContentAdLoadedListener : NSObject<AdLoadedListener>

- (instancetype) initWithDelegate:(id<OysterContentAdLoaderDelegate>) delegate adLoader:(OysterAdLoader*) adLoader;
@end