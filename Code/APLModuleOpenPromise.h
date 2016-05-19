//
//  APLModuleOpenPromise.h
//  PresentationTest
//
//  Created by Semyon Belokovsky on 20/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APLModuleInput;
@protocol APLModuleOutput;

typedef void(^APLModulePostLinkBlock)();

typedef id<APLModuleOutput>(^APLModuleLinkBlock)(id<APLModuleInput> moduleInput);

@interface APLModuleOpenPromise : NSObject

@property (nonatomic, strong) id<APLModuleInput> moduleInput;
@property (nonatomic, strong) APLModulePostLinkBlock postLinkBlock;

- (void)linkWithBlock:(APLModuleLinkBlock)linkBlock;

@end
