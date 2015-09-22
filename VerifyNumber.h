//
//  VerifyNumber.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 14/09/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface VerifyNumber : NSManagedObject

@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * isVerified;

@end
