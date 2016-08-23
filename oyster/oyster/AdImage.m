//
// Created by liq on 8/23/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import "AdImage.h"

@implementation AdImage
- (instancetype) initWithUrl:(NSString*) url {
  self = [super init];
  if (self) {
    _url = url;
  }

  return self;
}

@end