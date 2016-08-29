//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import "AdImageDto.h"

@implementation AdImageDto

- (instancetype) initWithWidth:(long) width height:(long) height url:(NSString*) url {
  self = [super init];
  if (self) {
    _width = width;
    _height = height;
    _url = url;
  }

  return self;
}

@end