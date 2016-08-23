//
// Created by liq on 8/22/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import "AdDto.h"
#import "AdLinkDto.h"
#import "AdImageDto.h"
#import "AdSponsorDto.h"
#import "AdViewModel.h"
#import "AdImage.h"

@implementation AdDto

- (instancetype) initWithTitle:(NSString*) title
                       summary:(NSString*) summary
                          link:(AdLinkDto*) link
                    middleIcon:(AdImageDto*) middleIcon
                   middleImage:(AdImageDto*) middleImage
                       sponsor:(AdSponsorDto*) sponsor
                    largeImage:(AdImageDto*) largeImage
                    smallImage:(AdImageDto*) smallImage
                     largeIcon:(AdImageDto*) largeIcon
                     smallIcon:(AdImageDto*) smallIcon
              impressionEvents:(NSArray<NSString*>*) impressionEvents
                    viewEvents:(NSArray<NSString*>*) viewEvents {
  self = [super init];
  if (self) {
    _title = title;
    _summary = summary;
    _link = link;
    _middleIcon = middleIcon;
    _middleImage = middleImage;
    _sponsor = sponsor;
    _largeImage = largeImage;
    _smallImage = smallImage;
    _largeIcon = largeIcon;
    _smallIcon = smallIcon;
    _impressionEvents = impressionEvents;
    _viewEvents = viewEvents;
  }

  return self;
}

- (AdViewModel*) createAdViewModel {
  return [[AdViewModel alloc]
      initWithTitle:self.title
            summary:self.summary
               link:self.link.url
            sponsor:self.sponsor.title
               icon:[[AdImage alloc] initWithUrl:self.middleIcon.url]
              image:[[AdImage alloc] initWithUrl:self.middleImage.url]
   impressionEvents:self.impressionEvents
         viewEvents:self.viewEvents];

}

@end