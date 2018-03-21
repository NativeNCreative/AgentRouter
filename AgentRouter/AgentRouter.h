//
//  AgentRouter.h
//  AgentRouter
//
//  Created by Rezeq, Maher on 3/15/18.
//  Copyright © 2018 NativeNCreative. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgentRouter : NSObject

+ (id)sharedInstance;
- (void)registerProtocolReuest:(Protocol *)protocol fromAgentProtocol:(Protocol *)agentProtocol usingAgentClass:(Class)clazz;
- (void)registerProtocolReuest:(Protocol *)protocol fromAgentProtocol:(Protocol *)agentProtocol usingAgentObject:(id)object;
- (id)agentForProtocol:(Protocol *)protocol;

@end

NS_ASSUME_NONNULL_END
