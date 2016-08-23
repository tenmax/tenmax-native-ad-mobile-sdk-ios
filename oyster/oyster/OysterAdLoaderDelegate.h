//
// Created by liq on 8/19/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OysterAdLoader;

@protocol OysterAdLoaderDelegate<NSObject>

/// Called when adLoader fails to load an ad.
- (void)adLoader:(OysterAdLoader *)adLoader didFailToReceiveAdWithError:(NSError *)error;

@end