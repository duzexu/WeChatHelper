//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSString;

@interface MMPingOperationData : NSObject
{
    int _status;
    NSString *_destinationComputer;
    double _pingDuration;
}

- (void).cxx_destruct;
@property(copy, nonatomic) NSString *destinationComputer; // @synthesize destinationComputer=_destinationComputer;
@property(nonatomic) double pingDuration; // @synthesize pingDuration=_pingDuration;
@property(nonatomic) int status; // @synthesize status=_status;

@end

