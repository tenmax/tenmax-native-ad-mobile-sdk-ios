//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import "AdSponsorDto.h"
#import "AdLinkDto.h"

@implementation AdSponsorDto

- (instancetype) initWithLink:(AdLinkDto*) link title:(NSString*) title {
  self = [super init];
  if (self) {
    _link = link;
    _title = title;
  }

  return self;
}

@end