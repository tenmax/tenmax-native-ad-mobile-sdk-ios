//
// Created by liq on 8/19/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OysterAd.h"
#import "OysterAdLoaderDelegate.h"

@class OysterAdImage;
@class OysterAdLoader;

@interface OysterContentAd : OysterAd
#pragma mark - Must be displayed

@property (nonatomic, readonly, copy) NSString* headline;
@property (nonatomic, readonly, copy) NSString* body;

#pragma mark - Recommended to display

@property (nonatomic, readonly, copy) NSArray* images;
@property (nonatomic, readonly, strong) OysterAdImage* logo;
@property (nonatomic, readonly, copy) NSString* callToAction;
@property (nonatomic, readonly, copy) NSString* advertiser;
@end

#pragma mark - Protocol and constants

@protocol OysterContentAdLoaderDelegate<OysterAdLoaderDelegate>

- (void) adLoader:(OysterAdLoader*) adLoader didReceiveNativeContentAd:(OysterContentAd*) nativeContentAd;

@end