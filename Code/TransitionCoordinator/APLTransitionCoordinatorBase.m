//
//  APLTransitionCoordinatorBase.m
//  PresentationTest
//
//  Created by Semyon Belokovsky on 20/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "APLTransitionCoordinatorBase.h"
#import "APLModuleOpenPromise.h"
#import "APLTransitionHandler.h"

@interface APLTransitionCoordinatorBase ()

@end

@implementation APLTransitionCoordinatorBase

- (void)configureDestinationController:(UIViewController *)viewController {
    if ([self _canCoordinateTransition]) {
        viewController.modalPresentationStyle = UIModalPresentationCustom;
        viewController.transitioningDelegate = (id<UIViewControllerTransitioningDelegate>)self;
    }
}

- (BOOL)_canCoordinateTransition
{
    BOOL result = NO;
    
    if ([self conformsToProtocol:@protocol(UIViewControllerTransitioningDelegate)] &&
        [self conformsToProtocol:@protocol(UIViewControllerAnimatedTransitioning)]) {
        result = YES;
    }
    
    return result;
}

@end
