//
//  UIViewController+APLTransitionHandler.m
//  PresentationTest
//
//  Created by Semyon Belokovsky on 20/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "UIViewController+APLTransitionHandler.h"
#import "APLModuleOpenPromise.h"
#import "APLTransitionCoordinator.h"

#import <objc/runtime.h>

static IMP originalPrepareForSegueMethodImp;

@implementation UIViewController (APLTransitionHandler)

@dynamic moduleInput;
@dynamic coordinator;

+ (void)initialize {
    [self swizzlePrepareForSegue];
}

#pragma mark - APLTransitionHandler

- (APLModuleOpenPromise *)openModuleWithSegueIdentifier:(NSString *)segueIdentifier {
    APLModuleOpenPromise *promise = [APLModuleOpenPromise new];
    
    UIStoryboardSegue *segue = nil;
    if ([self respondsToSelector:@selector(coordinator)]) {
        if ([self.coordinator respondsToSelector:@selector(segueWithId:)]) {
            segue = [self.coordinator segueWithId:segueIdentifier];
        }
    }
    dispatch_async(dispatch_get_main_queue(),
    ^{
        if (segue) {
            [segue perform];
        } else {
            [self performSegueWithIdentifier:segueIdentifier sender:promise];
        }
    });
    
    return promise;
}

- (APLModuleOpenPromise *)openModuleWithAPLSegue:(APLSegue *)segue linkBlock:(APLModuleLinkBlock)linkBlock {
    APLModuleOpenPromise *promise = [APLModuleOpenPromise new];
    
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       if (segue) {
                           id<APLModuleInput> moduleInput = nil;
                           
                           UIViewController *destinationViewController = segue.destination;
                           
                           [self _configureDestination:destinationViewController];
                           
                           if ([destinationViewController isKindOfClass:[UINavigationController class]]) {
                               UINavigationController *navigationController = segue.destination;
                               destinationViewController = navigationController.topViewController;
                           }
                           
                           id<APLTransitionHandler> targetModuleTransitionHandler = destinationViewController;
                           if ([targetModuleTransitionHandler respondsToSelector:@selector(moduleInput)]) {
                               moduleInput = [targetModuleTransitionHandler moduleInput];
                           }
                           
                           promise.moduleInput = moduleInput;
                           [promise linkWithBlock:linkBlock];
                           
                           [segue perform];
                       }
                   });    
    return promise;
}

#pragma mark - PrepareForSegue swizzling

+ (void)swizzlePrepareForSegue {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
    ^{
        IMP reamplerPrepareForSegueImp = (IMP)APLPrepareForSegueSender;
        
        Method prepareForSegueMethod = class_getInstanceMethod([self class], @selector(prepareForSegue:sender:));
        originalPrepareForSegueMethodImp = method_setImplementation(prepareForSegueMethod, reamplerPrepareForSegueImp);
    });
}

void APLPrepareForSegueSender(id self, SEL selector, UIStoryboardSegue *segue, id sender) {
    
    ((void(*)(id,SEL,UIStoryboardSegue*,id))originalPrepareForSegueMethodImp)(self, selector, segue, sender);
    
    if (![sender isKindOfClass:[APLModuleOpenPromise class]]) {
        return;
    }
    
    id<APLModuleInput> moduleInput = nil;
    
    UIViewController *destinationViewController = segue.destinationViewController;
    
    [self _configureDestination:destinationViewController];
    
    if ([destinationViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = segue.destinationViewController;
        destinationViewController = navigationController.topViewController;
    }
    
    id<APLTransitionHandler> targetModuleTransitionHandler = destinationViewController;
    if ([targetModuleTransitionHandler respondsToSelector:@selector(moduleInput)]) {
        moduleInput = [targetModuleTransitionHandler moduleInput];
    }
    
    APLModuleOpenPromise *openModulePromise = sender;
    openModulePromise.moduleInput = moduleInput;
}

- (void)_configureDestination:(UIViewController *)destination {
    if ([self respondsToSelector:@selector(coordinator)]) {
        if ([self.coordinator respondsToSelector:@selector(configureDestinationController:)]) {
            [self.coordinator configureDestinationController:destination];
        }
    }
}

@end
