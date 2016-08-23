//
//  OysterContentAdView.m
//  oyster
//
//  Created by liq on 8/19/16.
//  Copyright © 2016 tenmax. All rights reserved.
//

#import "OysterContentAdView.h"
#import "OysterContentAd.h"

@implementation OysterContentAdView

- (void) setOysterContentAd:(OysterContentAd*) oysterContentAd {
  _oysterContentAd = oysterContentAd;

  UITapGestureRecognizer* tapGestureRecognizer;
  tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
  tapGestureRecognizer.numberOfTapsRequired = 1;
  [self addGestureRecognizer:tapGestureRecognizer];
}

- (void) singleTap:(id) singleTap {
  if (self.oysterContentAd) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.oysterContentAd valueForKey:@"link"]]];
  }
}

@end
