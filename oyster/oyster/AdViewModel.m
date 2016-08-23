//
// Created by liq on 8/23/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import "AdViewModel.h"
#import "OysterAdImage.h"
#import "AdImage.h"

@implementation AdViewModel

- (instancetype) initWithTitle:(NSString*) title
                       summary:(NSString*) summary
                          link:(NSString*) link
                       sponsor:(NSString*) sponsor
                          icon:(AdImage*) icon
                         image:(AdImage*) image
              impressionEvents:(NSArray<NSString*>*) impressionEvents
                    viewEvents:(NSArray<NSString*>*) viewEvents {
  self = [super init];
  if (self) {
    _title = title;
    _summary = summary;
    _link = link;
    _sponsor = sponsor;
    _icon = icon;
    _image = image;
    _impressionEvents = impressionEvents;
    _viewEvents = viewEvents;
  }

  return self;
}

@end