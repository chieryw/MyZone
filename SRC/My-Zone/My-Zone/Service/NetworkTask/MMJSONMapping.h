//
//  QWJSONMapping.h
//  QunariPhone
//
//  Created by chieryW on 14/12/1.
//  Copyright (c) 2015年 MyZone.com All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMSearchNetResult.h"

@interface MMJSONMapping : NSObject

/**
 *  自动 JSON Mapping，数组类型的属性需要声明子类型同名的协议，如果没有声明协议则不解析非NSString类型结果。
 *
 *  @param object
 *  @param jsonDictionary 
 */
+ (void)mappingObject:(id)object withJSON:(NSDictionary *)jsonDictionary;

@end
