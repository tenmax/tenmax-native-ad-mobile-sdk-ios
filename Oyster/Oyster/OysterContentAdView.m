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
@property (nonatomic, readwrite, strong) NSTimer* timer;
@property (nonatomic, readwrite, strong) NSTimer* detectDisplayAreaTimer;

@end

@implementation OysterContentAdView

- (void) setOysterContentAd:(OysterContentAd*) oysterContentAd {
  _oysterContentAd = oysterContentAd;
}

- (void) tryDetermine {
  [self tryDetectDisplayArea];
  self.detectDisplayAreaTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                                 target:self
                                                               selector:@selector(tryDetectDisplayArea)
                                                               userInfo:nil
                                                                repeats:YES];
  [[NSRunLoop mainRunLoop] addTimer:self.detectDisplayAreaTimer forMode:NSRunLoopCommonModes];
  [self.detectDisplayAreaTimer fire];
}

- (void) tryDetectDisplayArea {
  if (!self.oysterContentAd || [self isHidden]) {
    return;
  }
  if (self.viewEventSend) {
    [self.detectDisplayAreaTimer invalidate];
    self.detectDisplayAreaTimer = nil;
    return;
  }
  if (self.determine) {
    return;
  }
  if ([self detectDisplayArea]) {
    self.determine = YES;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(detectKeepDisplay)
                                                userInfo:nil
                                                 repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
  }
}

- (BOOL) detectDisplayArea {

  CGRect adViewRect = [self convertRect:self.frame toView:self.window];

  CGFloat percent = 0;
  if (adViewRect.size.width != 0 || adViewRect.size.height != 0) {
    CGFloat visibleWidth = [self getVisibleX:(adViewRect.origin.x + adViewRect.size.width)]
        - [self getVisibleX:adViewRect.origin.x];
    CGFloat visibleHeight = [self getVisibleY:(adViewRect.origin.y + adViewRect.size.height)]
        - [self getVisibleY:adViewRect.origin.y];

    percent = visibleHeight * visibleWidth / (self.frame.size.width * self.frame.size.height);
  }
  return percent > 0.5f;
}

- (void) detectKeepDisplay {
  if ([self detectDisplayArea]) {
    if (!self.viewEventSend) {
      self.viewEventSend = YES;
      [self sendViewEvent];
    }
  } else {
    self.determine = NO;
  }

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

- (void) layoutSubviews {
  [super layoutSubviews];

  UITapGestureRecognizer* tapGestureRecognizer;
  tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
  tapGestureRecognizer.numberOfTapsRequired = 1;

  [self addGestureRecognizer:tapGestureRecognizer];

  self.viewEventSend = NO;
  self.determine = NO;
  [self.timer invalidate];
  self.timer = nil;
  [self.detectDisplayAreaTimer invalidate];
  self.detectDisplayAreaTimer = nil;

  [self tryDetermine];
}

@end
