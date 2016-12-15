//
//  APLModuleOpenPromise.m
//  PresentationTest
//
//  Created by Semyon Belokovsky on 20/05/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "APLModuleOpenPromise.h"
#import "APLModuleInput.h"

@interface APLModuleOpenPromise ()

@property (nonatomic, copy) APLModuleLinkBlock linkBlock;
@property (nonatomic, assign) BOOL linkBlockWasSet;
@property (nonatomic, assign) BOOL moduleInputWasSet;

@end

@implementation APLModuleOpenPromise

- (void)setModuleInput:(id<APLModuleInput>)moduleInput {
    _moduleInput = moduleInput;
    self.moduleInputWasSet = YES;
    [self _tryPerformLink];
}

- (void)linkWithBlock:(APLModuleLinkBlock)linkBlock {
    _linkBlock = linkBlock;
    self.linkBlockWasSet = YES;
    [self _tryPerformLink];
}

#pragma mark - Private

- (void)_tryPerformLink {
    if (self.linkBlockWasSet && self.moduleInputWasSet)
    {
        [self _performLink];
    }
}

- (void)_performLink {
    if (self.linkBlock) {
        id<APLModuleOutput> moduleOutput = self.linkBlock(self.moduleInput);
        if ([self.moduleInput respondsToSelector:@selector(setModuleOutput:)]) {
            [self.moduleInput setModuleOutput:moduleOutput];
        }
        if (self.postLinkBlock) {
            self.postLinkBlock();
        }
    }
}

@end
