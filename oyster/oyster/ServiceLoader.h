//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OysterAdLoader.h"

@class ContentAdLoadedListener;
@class OysterAdLoaderOptions;

@interface ServiceLoader : NSObject

@property (nonatomic, readwrite, strong) ContentAdLoadedListener* contentAdLoadedListener;

- (instancetype) initWithAdUnitID:(NSString*) adUnitID options:(OysterAdLoaderOptions*) options;

- (void) loadAd;
@end