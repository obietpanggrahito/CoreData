//
//  Teacher+CoreDataProperties.h
//  StudentDirectory
//
//  Created by Obiet Panggrahito on 28/03/2017.
//  Copyright © 2017 Obiet Panggrahito. All rights reserved.
//

#import "Teacher+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Teacher (CoreDataProperties)

+ (NSFetchRequest<Teacher *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *subject;

@end

NS_ASSUME_NONNULL_END
