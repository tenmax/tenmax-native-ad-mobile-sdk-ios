//
// Created by liq on 8/19/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import "OysterAdImage.h"

@implementation OysterAdImage

- (instancetype) initWithImage:(UIImage*) image imageURL:(NSString*) imageURL {
  self = [super init];
  if (self) {
    _image = image;
    _imageURL = imageURL;
  }

  return self;
}

@end