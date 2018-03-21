//
//  AgentHandler.h
//  AgentRouter
//
//  Created by Rezeq, Maher on 3/15/18.
//  Copyright © 2018 NativeNCreative. All rights reserved.
//

@import Foundation;

@interface AgentHandler : NSProxy

@property (nonatomic, strong) id object;

- (instancetype)initWithProtocol:(Protocol *)protocol andImplementationClass:(Class)clazz;
- (instancetype)initWithProtocol:(Protocol *)protocol andImplementationObject:(id)object;

@end
