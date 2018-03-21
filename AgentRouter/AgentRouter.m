//
//  AgentRouter.m
//  AgentRouter
//
//  Created by Rezeq, Maher on 3/15/18.
//  Copyright © 2018 NativeNCreative. All rights reserved.
//

#import "AgentRouter.h"
#import "AgentHandler.h"

@interface Handler : NSObject

@property(nonatomic) Protocol *protocolHandler;
@property(nonatomic) Protocol *protocol;
@property(nonatomic) Class clazz;
@property(nonatomic) AgentHandler *handlerAgent;

- (instancetype)initWithProtocolReuest:(Protocol *)protocol forAgentProtocol:(Protocol *)agentProtocol usingAgentClass:(Class)clazz;
- (instancetype)initWithProtocolReuest:(Protocol *)protocol forAgentProtocol:(Protocol *)agentProtocol usingAgentObject:(id)agentObject;
@end

@implementation Handler

- (instancetype)initWithProtocolReuest:(Protocol *)protocol forAgentProtocol:(Protocol *)agentProtocol usingAgentClass:(Class)clazz {
    
    self = [super init];
    if (self) {
        _protocolHandler = protocol;
        _protocol = agentProtocol;
        _clazz = clazz;
        _handlerAgent = [[AgentHandler alloc] initWithProtocol:agentProtocol andImplementationClass:clazz];
    }
    return self;
}

- (instancetype)initWithProtocolReuest:(Protocol *)protocol forAgentProtocol:(Protocol *)agentProtocol usingAgentObject:(id)agentObject {
    self = [super init];
    if (self) {
        _protocolHandler = protocol;
        _protocol = agentProtocol;
        _clazz = [agentObject class];
        _handlerAgent = [[AgentHandler alloc] initWithProtocol:agentProtocol andImplementationObject:agentObject];
    }
    return self;
}

@end

@interface AgentRouter()
@property(nonatomic) NSMutableDictionary<NSString *, Handler *> *mapping;
@end


@implementation AgentRouter

+ (id)sharedInstance {
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (instancetype _Nullable)init {
    self = [super init];
    if (self) {
        _mapping = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registerProtocolReuest:(Protocol *)protocol fromAgentProtocol:(Protocol *)agentProtocol usingAgentClass:(Class)clazz {
    Handler *handler = [[Handler alloc] initWithProtocolReuest:protocol forAgentProtocol:agentProtocol usingAgentClass:clazz];
    NSString *name = NSStringFromProtocol(handler.protocol);
    if (name) {
        self.mapping[name] = handler;
    }
}

- (void)registerProtocolReuest:(Protocol *)protocol fromAgentProtocol:(Protocol *)agentProtocol usingAgentObject:(id)object {
    Handler *handler = [[Handler alloc] initWithProtocolReuest:protocol forAgentProtocol:agentProtocol usingAgentObject:object];
    NSString *name = NSStringFromProtocol(handler.protocol);
    if (name) {
        self.mapping[name] = handler;
    }
}

- (id)agentForProtocol:(Protocol *)protocol {
    NSString *name = NSStringFromProtocol(protocol);
    return self.mapping[name].handlerAgent;
}
@end
