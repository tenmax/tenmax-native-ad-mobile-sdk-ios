//
//  OysterAdView.h
//  Oyster
//
//  Created by liq on 9/7/16.
//  Copyright © 2016 tenmax. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "OysterContentAd.h"
#import "OysterContentAdView.h"

@interface OysterAdView : OysterContentAdView<OysterContentAdLoaderDelegate>

@property (nonatomic, readwrite, strong) NSString* adUnitID;
@property (nonatomic, readwrite, weak) IBOutlet UIViewController* rootViewController;

- (void) loadAds;

+ (void) _keepAtLinkTime;

@end
