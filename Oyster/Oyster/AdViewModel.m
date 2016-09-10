//
// Created by liq on 8/23/16.
// Copyright (c) 2016 tenmax. All rights reserved.
//

#import "AdViewModel.h"
#import "OysterAdImage.h"
#import "AdImage.h"
#import "OysterContentAd.h"

@implementation AdViewModel

- (instancetype) initWithTitle:(NSString*) title
                       summary:(NSString*) summary
                          link:(NSString*) link
                       sponsor:(NSString*) sponsor
                          icon:(AdImage*) icon
                         image:(AdImage*) image
              impressionEvents:(NSArray<NSString*>*) impressionEvents
                    viewEvents:(NSArray<NSString*>*) viewEvents
                  callToAction:(NSString*) callToAction {
  self = [super init];
  if (self) {
    _title = title;
    _summary = summary;
    _link = link;
    _sponsor = sponsor;
    _icon = icon;
    _adImage = image;
    _impressionEvents = impressionEvents;
    _viewEvents = viewEvents;
    _callToAction = callToAction;
  }

  return self;
}

- (OysterContentAd*) createFormatOysterContentAd {
  OysterContentAd* oysterContentAd = [[OysterContentAd alloc] init];
  [oysterContentAd setValue:self.title forKey:NSStringFromSelector(@selector(headline))];
  [oysterContentAd setValue:self.summary forKey:NSStringFromSelector(@selector(body))];
  [oysterContentAd setValue:[[OysterAdImage alloc] initWithImage:self.adImage.image imageURL:self.adImage.url]
                     forKey:NSStringFromSelector(@selector(adImage))];
  [oysterContentAd setValue:[[OysterAdImage alloc] initWithImage:self.icon.image imageURL:self.icon.url]
                     forKey:NSStringFromSelector(@selector(adLogo))];
  [oysterContentAd setValue:self.sponsor forKey:NSStringFromSelector(@selector(advertiser))];
  [oysterContentAd setValue:self.viewEvents forKey:NSStringFromSelector(@selector(viewEvents))];
  [oysterContentAd setValue:self.link forKey:NSStringFromSelector(@selector(link))];
  [oysterContentAd setValue:self.callToAction forKey:NSStringFromSelector(@selector(callToAction))];

  return oysterContentAd;
}

@end