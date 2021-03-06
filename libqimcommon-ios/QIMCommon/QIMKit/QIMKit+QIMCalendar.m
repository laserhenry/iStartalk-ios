//
//  QIMKit+QIMCalendar.m
//  QIMCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import "QIMKit+QIMCalendar.h"
#import "QIMPrivateHeader.h"

@implementation STKit (QIMCalendar)

- (NSArray *)selectTripByYearMonth:(NSString *)date {
    return [[STManager sharedInstance] selectTripByYearMonth:date];
}

- (void)createTrip:(NSDictionary *)param callBack:(QIMKitCreateTripBlock)callback {
    [[STManager sharedInstance] createTrip:param callBack:callback];
}

- (void)getTripAreaAvailableRoom:(NSDictionary *)dateDic callBack:(QIMKitGetTripAreaAvailableRoomBlock)callback {
    [[STManager sharedInstance] getTripAreaAvailableRoom:dateDic callBack:callback];
}

- (void)tripMemberCheck:(NSDictionary *)params callback:(QIMKitGetTripMemberCheckBlock)callback {
    [[STManager sharedInstance] tripMemberCheck:params callback:callback];
}

- (void)getAllCityList:(QIMKitGetTripAllCitysBlock)callback {
    [[STManager sharedInstance] getAllCityList:callback];
}

- (void)getAreaByCityId:(NSDictionary *)params :(QIMKitGetTripAreaAvailableRoomByCityIdBlock)callback {
    [[STManager sharedInstance] getAreaByCityId:params :callback];
}

- (NSArray *)getLocalAreaList {
    return [[STManager sharedInstance] getLocalAreaList];
}

- (void)getRemoteAreaList {
    [[STManager sharedInstance] getRemoteAreaList];
}

@end
