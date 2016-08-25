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
@property (nonatomic, readwrite, assign) BOOL viewEventSend;
@property (nonatomic, readwrite, assign) CFAbsoluteTime visibleStart;
@property (nonatomic, readwrite, strong) NSTimer* timer;;

@end

@implementation OysterContentAdView

- (void) setOysterContentAd:(OysterContentAd*) oysterContentAd {
  _oysterContentAd = oysterContentAd;
}

- (void) tryDetermine {
  if (self.determine || self.viewEventSend) {
    return;
  }
  self.determine = YES;
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
      if (self.visibleStart == 0) {
        self.visibleStart = CFAbsoluteTimeGetCurrent();
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(determineDisplayArea)
                                                    userInfo:nil
                                                     repeats:NO];
        [self.timer fire];
        return;
      } else {
        if (!self.viewEventSend) {
          self.viewEventSend = YES;
          [self sendViewEvent];
        }
      }
    }
  }
  self.visibleStart = 0;
  self.determine = NO;
}

- (void) sendViewEvent {
  if (!self.oysterContentAd) {
    return;
  }
  NSArray<NSString*>* viewEvents = [self.oysterContentAd valueForKey:@"viewEvents"];
  for (int i = 0; i < viewEvents.count; ++i) {
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[[NSURL alloc] initWithString:viewEvents[(NSUInteger) i]]];
    [request setHTTPMethod:@"GET"];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
    }] resume];
  }
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

  self.viewEventSend = NO;
  self.determine = NO;
  self.visibleStart = 0;
  [self.timer invalidate];
  self.timer = nil;
}

- (void) layoutSubviews {
  [super layoutSubviews];
  [self tryDetermine];
}

@end
