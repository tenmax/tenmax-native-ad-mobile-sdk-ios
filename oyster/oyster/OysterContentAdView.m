//
//  OysterContentAdView.m
//  oyster
//
//  Created by liq on 8/19/16.
//  Copyright © 2016 tenmax. All rights reserved.
//

#import "OysterContentAdView.h"
#import "OysterContentAd.h"

@interface OysterContentAdView()
@property (nonatomic, readwrite, assign) BOOL determine;
@property (nonatomic, readwrite, assign) BOOL viewEvent;
@property (nonatomic, readwrite, assign) long visibleStart;

@end

@implementation OysterContentAdView

- (void) setOysterContentAd:(OysterContentAd*) oysterContentAd {
  _oysterContentAd = oysterContentAd;
}

- (void) tryDetermine {
  if (self.determine || self.viewEvent) {
    return;
  }
  self.determine = true;
  [self determineDisplayArea];
}

- (void) determineDisplayArea {
  if (!self.oysterContentAd || [self isHidden]) {
    self.visibleStart = 0;
    self.determine = NO;
    return;
  }

  CGRect adViewRect = [self convertRect:self.frame toView:self.window];

  if (adViewRect.size.width != 0 || adViewRect.size.height != 0) {
    CGFloat visibleWidth = [self getVisibleX:(adViewRect.origin.x + adViewRect.size.width)]
        - [self getVisibleX:adViewRect.origin.x];
    CGFloat visibleHeight = [self getVisibleY:(adViewRect.origin.y + adViewRect.size.height)]
        - [self getVisibleX:adViewRect.origin.y];

    CGFloat percent = visibleHeight * visibleWidth / (self.bounds.size.width * self.bounds.size.height);
    if (percent >= 0.5f) {
      //#TODO timer start one sec
      return;
    }
  }
  self.visibleStart = 0;
  self.determine = NO;
}

- (CGFloat) getVisibleX:(CGFloat) x {
  if (x < 0) {
    return 0;
  }
  CGFloat screenX = [[UIScreen mainScreen] bounds].size.width;
  if (x > screenX) {
    return screenX;
  }
  return x;
}

- (CGFloat) getVisibleY:(CGFloat) y {
  if (y < 0) {
    return 0;
  }
  CGFloat screenY = [[UIScreen mainScreen] bounds].size.height;
  if (y > screenY) {
    return screenY;
  }
  return y;
}

- (void) singleTap:(id) singleTap {
  if (self.oysterContentAd) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[self.oysterContentAd valueForKey:@"link"]]];
  }
}

- (void) addSubview:(UIView*) view {
  [super addSubview:view];
  UITapGestureRecognizer* tapGestureRecognizer;
  tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
  tapGestureRecognizer.numberOfTapsRequired = 1;
  [view addGestureRecognizer:tapGestureRecognizer];
}

- (void) didMoveToWindow {
  [super didMoveToWindow];
  UITapGestureRecognizer* tapGestureRecognizer;
  tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
  tapGestureRecognizer.numberOfTapsRequired = 1;

  [self addGestureRecognizer:tapGestureRecognizer];
}

- (void) layoutSubviews {
  [super layoutSubviews];
  [self tryDetermine];
}

@end
