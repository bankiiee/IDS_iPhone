//
//  Member.h
//  IDS_NOSTRB
//
//  Created by Sakarn Limnitikarn on 24/01/2012.
//  Copyright (c) 2012 bankiiee@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Member : NSManagedObject

@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * role;

@end
