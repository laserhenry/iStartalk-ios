//
//  QIMRSACoder.h
//  qunarChatCommon
//
//  StarTalk IMSDK-iOS
//
//  Created by Lucas on 11/29/18.
//  Copyright © 2018 QIM. All rights reserved.
//  Copyright © 2021 StarTalk Limited. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface STRSACoder : NSObject

+ (SecKeyRef)publicKey:(NSString *) certPath;

+ (NSString *)RSAEncrypotoTheData:(NSString *)plainText withPublicKey:(SecKeyRef) publicKey;

+ (NSData *) RSAEncrypotoText:(NSString *)plainText withPublicKey:(SecKeyRef) publicKey;

+ (NSData *) RSAYourText:(NSString *) text withPublicKeyFile:(NSString *) fileName;

+ (NSString *) encryptByRsa:(NSString*)content;

+ (NSString *) encryptByRsa:(NSString*)content publicKeyFileName:(NSString *) fileName;

+ (NSString *) rsaYourText:(NSString *) text;
+ (NSString *) writeRSAFile:(NSString *) publicKey;

+ (NSString *) RSAForPassword:(NSString *)password;

@end
