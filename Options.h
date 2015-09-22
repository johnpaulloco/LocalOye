//
//  Options.h
//  LocalOye
//
//  Created by Imma Web Pvt Ltd on 26/08/15.
//  Copyright (c) 2015 Imma Web Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Options : NSManagedObject

@property (nonatomic, retain) NSString * optionStr;
@property (nonatomic, retain) NSString * questionStr;
@property (nonatomic, retain) NSNumber * nextQuestionIndex;

@end
