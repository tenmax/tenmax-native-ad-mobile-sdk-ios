//
// Created by liq on 8/25/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import "OysterContentAdCell.h"
@import Oyster;

@implementation OysterContentAdCell

- (instancetype) initWithFrame:(CGRect) frame {
  self = [super initWithFrame:frame];
  if (self) {
    _oysterContentAdView = [[[NSBundle mainBundle]
        loadNibNamed:@"NativeContentAdView" owner:nil options:nil]
        firstObject];
    _oysterContentAdView.frame = self.bounds;
    [self.contentView addSubview:_oysterContentAdView];

  }

  return self;
}

@end