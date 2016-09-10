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
#import "OysterAdLoader.h"

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
                    viewEvents:(NSArray<NSString*>*) viewEvents
                  callToAction:(NSString*) callToAction {
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
    _callToAction = callToAction;
  }

  return self;
}

- (AdViewModel*) createAdViewModel:(OysterAdLoaderOptions*) options {
  NSString* imageUrl = self.middleImage.url;
  NSString* iconUrl = self.middleIcon.url;
  if (options) {
    switch (options.imageSize) {
      case LARGE:
        imageUrl = self.largeImage.url;
        iconUrl = self.largeIcon.url;
        break;
      case MIDDLE:
        imageUrl = self.middleImage.url;
        iconUrl = self.middleIcon.url;
        break;
      case SMALL:
        imageUrl = self.smallImage.url;
        iconUrl = self.smallIcon.url;
        break;
    }
  }
  return [[AdViewModel alloc]
      initWithTitle:self.title
            summary:self.summary
               link:self.link.url
            sponsor:self.sponsor.title
               icon:[[AdImage alloc] initWithUrl:iconUrl]
              image:[[AdImage alloc] initWithUrl:imageUrl]
   impressionEvents:self.impressionEvents
         viewEvents:self.viewEvents
       callToAction:self.callToAction];

}

@end