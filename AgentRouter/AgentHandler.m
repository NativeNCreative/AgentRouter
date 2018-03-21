//
//  AgentHandler.m
//  AgentRouter
//
//  Created by Rezeq, Maher on 3/15/18.
//  Copyright © 2018 NativeNCreative. All rights reserved.
//

#import "AgentHandler.h"

@implementation AgentHandler

- (instancetype)initWithProtocol:(Protocol *)protocol andImplementationClass:(Class)clazz {
    if ([clazz conformsToProtocol:protocol]) {
        self.object = [[clazz alloc] init];
    }else{
        NSLog(@"Error Class (%@) does not conform to protocol (%@)", clazz, protocol);
    }
    return self;
}

- (instancetype)initWithProtocol:(Protocol *)protocol andImplementationObject:(id)object {
    if ([object conformsToProtocol:protocol]) {
        self.object = object;
    }else{
        NSLog(@"Error Object (%@) does not conform to protocol (%@)", object, protocol);
    }
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSString *selString = NSStringFromSelector(invocation.selector);
    NSLog(@"Called %@",selString);
    if ([self.object respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:self.object];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    BOOL respondsToSelector = [self.object respondsToSelector:aSelector];
    if (!respondsToSelector) {
        NSLog(@"Unimplemented method -- respondsToSelector %@", NSStringFromSelector(aSelector));
    }
    return respondsToSelector;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [self.object methodSignatureForSelector:selector];
}

@end
