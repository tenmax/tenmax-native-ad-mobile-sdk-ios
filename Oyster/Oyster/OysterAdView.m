//
//  OysterAdView.m
//  Oyster
//
//  Created by liq on 9/7/16.
//  Copyright © 2016 tenmax. All rights reserved.
//

#import "OysterAdView.h"
#import "OysterAdLoader.h"
#import "OysterAdType.h"
#import "OysterAdImage.h"

@implementation OysterAdView

- (void) loadAds {
  if (!self.adUnitID) {
    NSLog(@"OysterAdView not have parents");
    return;
  }

  OysterAdLoaderOptions* options = [[OysterAdLoaderOptions alloc] init];
  options.imageSize = MIDDLE;

  OysterAdLoader* adLoader = [[OysterAdLoader alloc]
      initWithAdUnitID:self.adUnitID
    rootViewController:self.rootViewController
               adTypes:@[kOysterAdLoaderAdTypeContent]
               options:options];

  adLoader.delegate = self;
  [adLoader loadRequest];

}

- (void) adLoader:(OysterAdLoader*) adLoader didReceiveNativeContentAd:(OysterContentAd*) oysterContentAd {

  UIView* container = [[UIView alloc] initWithFrame:CGRectZero];
  container.backgroundColor = [UIColor blackColor];
  UIImageView* logoImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  UIImageView* callToActionImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  UILabel* headlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  headlineLabel.numberOfLines = 2;
  headlineLabel.font = [UIFont systemFontOfSize:10];
  headlineLabel.textColor = [UIColor whiteColor];
  UILabel* advertiserLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  advertiserLabel.font = [UIFont systemFontOfSize:8];
  advertiserLabel.textColor = [UIColor colorWithRed:129/255.0f green:212/255.0f blue:250/255.0f alpha:1];

  UIImage* image = [UIImage imageNamed:@"Oyster.framework/callTo.png"];
  callToActionImageView.image = image;

  [self addSubview:logoImageView];
  [self addSubview:callToActionImageView];
  [container addSubview:headlineLabel];
  [container addSubview:advertiserLabel];
  [self addSubview:container];

  [logoImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [callToActionImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
  [headlineLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [advertiserLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [container setTranslatesAutoresizingMaskIntoConstraints:NO];

  CGFloat imageSize;

  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    imageSize = 90;
  } else {
    imageSize = 50;
  }

  [self addConstraint:[NSLayoutConstraint constraintWithItem:logoImageView
                                                   attribute:NSLayoutAttributeCenterY
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self
                                                   attribute:NSLayoutAttributeCenterY
                                                  multiplier:1
                                                    constant:0]];

  [self addConstraint:[NSLayoutConstraint constraintWithItem:logoImageView
                                                   attribute:NSLayoutAttributeLeading
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self
                                                   attribute:NSLayoutAttributeLeading
                                                  multiplier:1
                                                    constant:0]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:logoImageView
                                                   attribute:NSLayoutAttributeWidth
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1
                                                    constant:imageSize]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:logoImageView
                                                   attribute:NSLayoutAttributeHeight
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1
                                                    constant:imageSize]];

  [self addConstraint:[NSLayoutConstraint constraintWithItem:callToActionImageView
                                                   attribute:NSLayoutAttributeCenterY
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self
                                                   attribute:NSLayoutAttributeCenterY
                                                  multiplier:1
                                                    constant:0]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:callToActionImageView
                                                   attribute:NSLayoutAttributeTrailing
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self
                                                   attribute:NSLayoutAttributeTrailing
                                                  multiplier:1
                                                    constant:0]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:callToActionImageView
                                                   attribute:NSLayoutAttributeWidth
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1
                                                    constant:imageSize]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:callToActionImageView
                                                   attribute:NSLayoutAttributeHeight
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:nil
                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                  multiplier:1
                                                    constant:imageSize]];

  [self addConstraint:[NSLayoutConstraint constraintWithItem:container
                                                   attribute:NSLayoutAttributeTop
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:logoImageView
                                                   attribute:NSLayoutAttributeTop
                                                  multiplier:1
                                                    constant:0]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:container
                                                   attribute:NSLayoutAttributeLeading
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:logoImageView
                                                   attribute:NSLayoutAttributeTrailing
                                                  multiplier:1
                                                    constant:0]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:container
                                                   attribute:NSLayoutAttributeTrailing
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:callToActionImageView
                                                   attribute:NSLayoutAttributeLeading
                                                  multiplier:1
                                                    constant:0]];
  [self addConstraint:[NSLayoutConstraint constraintWithItem:container
                                                   attribute:NSLayoutAttributeBottom
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:logoImageView
                                                   attribute:NSLayoutAttributeBottom
                                                  multiplier:1
                                                    constant:0]];

  [container addConstraint:[NSLayoutConstraint constraintWithItem:headlineLabel
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:container
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1
                                                         constant:8]];
  [container addConstraint:[NSLayoutConstraint constraintWithItem:headlineLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:container
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1
                                                         constant:8]];
  [container addConstraint:[NSLayoutConstraint constraintWithItem:headlineLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:container
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1
                                                         constant:0]];

  [container addConstraint:[NSLayoutConstraint constraintWithItem:advertiserLabel
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:container
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1
                                                         constant:-4]];
  [container addConstraint:[NSLayoutConstraint constraintWithItem:advertiserLabel
                                                        attribute:NSLayoutAttributeLeading
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:container
                                                        attribute:NSLayoutAttributeLeading
                                                       multiplier:1
                                                         constant:8]];
  [container addConstraint:[NSLayoutConstraint constraintWithItem:advertiserLabel
                                                        attribute:NSLayoutAttributeTrailing
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:container
                                                        attribute:NSLayoutAttributeTrailing
                                                       multiplier:1
                                                         constant:0]];

  self.headlineView = headlineLabel;
  self.logoView = logoImageView;
  self.advertiserView = advertiserLabel;

  [self setOysterContentAd:oysterContentAd];

  ((UILabel*) self.headlineView).text = oysterContentAd.headline;;
  ((UILabel*) self.advertiserView).text = oysterContentAd.advertiser;
  ((UIImageView*) self.logoView).image = oysterContentAd.adLogo.image;

}

- (void) adLoader:(OysterAdLoader*) adLoader didFailToReceiveAdWithError:(NSError*) error {
  NSLog(@"%@ failed with error: %@", adLoader, [error localizedDescription]);
}

+ (void) _keepAtLinkTime {

}
@end
