//
//  OysterContentAdView.h
//  oyster
//
//  Created by liq on 8/19/16.
//  Copyright © 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OysterAd.h"

@interface OysterContentAdView : UIView


@property(nonatomic, strong) OysterContentAdView *nativeContentAd;

@property(nonatomic, weak) IBOutlet UIView *headlineView;
@property(nonatomic, weak) IBOutlet UIView *bodyView;
@property(nonatomic, weak) IBOutlet UIView *imageView;
@property(nonatomic, weak) IBOutlet UIView *logoView;
@property(nonatomic, weak) IBOutlet UIView *callToActionView;
@property(nonatomic, weak) IBOutlet UIView *advertiserView;

@end
