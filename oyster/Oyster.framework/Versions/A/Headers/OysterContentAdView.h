//
//  OysterContentAdView.h
//  oyster
//
//  Created by liq on 8/19/16.
//  Copyright © 2016 tenmax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OysterAd.h"

@class OysterContentAd;

@interface OysterContentAdView : UIView

@property (nonatomic, strong) OysterContentAd* oysterContentAd;

@property (nonatomic, weak) IBOutlet UIView* headlineView;
@property (nonatomic, weak) IBOutlet UIView* bodyView;
@property (nonatomic, weak) IBOutlet UIView* imageView;
@property (nonatomic, weak) IBOutlet UIView* logoView;
@property (nonatomic, weak) IBOutlet UIView* advertiserView;

+ (void)_keepAtLinkTime;

@end
