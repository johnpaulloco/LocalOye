//
//  LocalOyeSharedManager.m
//  LocalOye
//
//  Created by John
//  Copyright (c) 2014 LocalOye. All rights reserved.
//

#import "LocalOyeSharedManager.h"
//#import "AFHTTPRequestOperationManager.h"
#import "LocalOyeConstants.h"

@implementation LocalOyeSharedManager

//Singleton for data manager
+(id)sharedManager {
    
    static LocalOyeSharedManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        //self.tripsArray             = [[NSMutableArray alloc] init];
        self.majorCategoryList        = [[NSMutableArray alloc] init];
        self.majorSkuList             = [[NSMutableArray alloc] init];
        self.addedSkus                = [[NSMutableArray alloc] init];
        self.selectedMajorSku         =  @"";
    }
    return self;
}

@end
