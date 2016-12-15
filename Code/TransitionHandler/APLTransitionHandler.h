//
//  APLTransitionHandler.h
//  PresentationTest
//
//  Created by Semyon Belokovsky on 20/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "APLSegue.h"
#import "APLModuleOpenPromise.h"

@class APLModuleOpenPromise;
@protocol APLModuleInput;
@protocol APLTransitionCoordinator;

@protocol APLTransitionHandler <NSObject>

@property (nonatomic, strong) id<APLModuleInput> moduleInput;
@property (nonatomic, strong) id<APLTransitionCoordinator> coordinator;

- (APLModuleOpenPromise *)openModuleWithSegueIdentifier:(NSString *)segueIdentifier;
- (APLModuleOpenPromise *)openModuleWithAPLSegue:(APLSegue *)segue linkBlock:(APLModuleLinkBlock)linkBlock;

@end
