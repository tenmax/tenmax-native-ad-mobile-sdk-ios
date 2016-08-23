//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import "AdLinkDto.h"

@implementation AdLinkDto


- (instancetype) initWithUrl:(NSString*) url clickTrackers:(NSArray<NSString*>*) clickTrackers {
  self = [super init];
  if (self) {
    _url = url;
    _clickTrackers = clickTrackers;
  }

  return self;
}

@end