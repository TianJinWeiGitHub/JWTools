//
//  NSFileManager+JWKit.m
//  AppKitLibrary
//
//  Created by jinwei on 15/10/19.
//  Copyright © 2015年 jinwei group. All rights reserved.
//

#import "NSFileManager+JWKit.h"
#import "JWToolCategory.h"

@implementation NSFileManager (JWKit)

+ (NSString *)readTextFile:(NSString *)file ofType:(NSString *)type
{
    return [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:file ofType:type] encoding:NSUTF8StringEncoding error:nil];
}

+ (BOOL)saveArrayToPath:(DirectoryType)path withFilename:(NSString *)fileName array:(NSArray *)array
{
    NSString *_path;
    
    switch(path)
    {
        case DirectoryTypeMainBundle:
            _path = [self getBundlePathForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case DirectoryTypeLibrary:
            _path = [self getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case DirectoryTypeDocuments:
            _path = [self getDocumentsDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case DirectoryTypeCache:
            _path = [self getCacheDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        default:
            break;
    }
    
    return [NSKeyedArchiver archiveRootObject:array toFile:_path];
}

+ (NSArray *)loadArrayFromPath:(DirectoryType)path withFilename:(NSString *)fileName
{
    NSString *_path;
    
    switch(path)
    {
        case DirectoryTypeMainBundle:
            _path = [self getBundlePathForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case DirectoryTypeLibrary:
            _path = [self getLibraryDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case DirectoryTypeDocuments:
            _path = [self getDocumentsDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        case DirectoryTypeCache:
            _path = [self getCacheDirectoryForFile:[NSString stringWithFormat:@"%@.plist", fileName]];
            break;
        default:
            break;
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
}

+ (NSString *)getBundlePathForFile:(NSString *)fileName
{
    NSString *fileExtension = [fileName pathExtension];
    return [[NSBundle mainBundle] pathForResource:[fileName stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", fileExtension] withString:@""] ofType:fileExtension];
}

+ (NSString *)getDocumentsDirectoryForFile:(NSString *)fileName
{
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", fileName]];
}

+ (NSString *)getLibraryDirectoryForFile:(NSString *)fileName
{
    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [libraryDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", fileName]];
}

+ (NSString *)getCacheDirectoryForFile:(NSString *)fileName
{
    NSString *cacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [cacheDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/", fileName]];
}

+ (NSNumber *)fileSize:(NSString *)fileName fromDirectory:(DirectoryType)directory
{
    if(fileName.length > 0)
    {
        NSString *path;
        
        switch(directory)
        {
            case DirectoryTypeMainBundle:
                path = [self getBundlePathForFile:fileName];
                break;
            case DirectoryTypeLibrary:
                path = [self getLibraryDirectoryForFile:fileName];
                break;
            case DirectoryTypeDocuments:
                path = [self getDocumentsDirectoryForFile:fileName];
                break;
            case DirectoryTypeCache:
                path = [self getCacheDirectoryForFile:fileName];
                break;
            default:
                break;
        }
        
        if([[NSFileManager defaultManager] fileExistsAtPath:fileName])
        {
            NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:fileName error:nil];
            if(fileAttributes)
            {
                return [fileAttributes objectForKey:NSFileSize];
            }
        }
    }
    
    return nil;
}

+ (BOOL)deleteFile:(NSString *)fileName fromDirectory:(DirectoryType)directory
{
    if(fileName.length > 0)
    {
        NSString *path;
        
        switch(directory)
        {
            case DirectoryTypeMainBundle:
                path = [self getBundlePathForFile:fileName];
                break;
            case DirectoryTypeLibrary:
                path = [self getLibraryDirectoryForFile:fileName];
                break;
            case DirectoryTypeDocuments:
                path = [self getDocumentsDirectoryForFile:fileName];
                break;
            case DirectoryTypeCache:
                path = [self getCacheDirectoryForFile:fileName];
                break;
            default:
                break;
        }
        
        if([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
    }
    
    return NO;
}

+ (BOOL)moveLocalFile:(NSString *)fileName fromDirectory:(DirectoryType)origin toDirectory:(DirectoryType)destination
{
    return [self moveLocalFile:fileName fromDirectory:origin toDirectory:destination withFolderName:nil];
}

+ (BOOL)moveLocalFile:(NSString *)fileName fromDirectory:(DirectoryType)origin toDirectory:(DirectoryType)destination withFolderName:(NSString *)folderName
{
    NSString *originPath;
    
    switch(origin)
    {
        case DirectoryTypeMainBundle:
            originPath = [self getBundlePathForFile:fileName];
            break;
        case DirectoryTypeLibrary:
            originPath = [self getDocumentsDirectoryForFile:fileName];
            break;
        case DirectoryTypeDocuments:
            originPath = [self getLibraryDirectoryForFile:fileName];
            break;
        case DirectoryTypeCache:
            originPath = [self getCacheDirectoryForFile:fileName];
            break;
        default:
            break;
    }
    
    NSString *destinationPath;
    if(folderName)
        destinationPath = [NSString stringWithFormat:@"%@/%@", folderName, fileName];
    else
        destinationPath = fileName;
    
    switch(destination)
    {
        case DirectoryTypeMainBundle:
            destinationPath = [self getBundlePathForFile:destinationPath];
            break;
        case DirectoryTypeLibrary:
            destinationPath = [self getLibraryDirectoryForFile:destinationPath];
            break;
        case DirectoryTypeDocuments:
            destinationPath = [self getDocumentsDirectoryForFile:destinationPath];
            break;
        case DirectoryTypeCache:
            destinationPath = [self getCacheDirectoryForFile:destinationPath];
            break;
        default:
            break;
    }
    
    if(folderName)
    {
        NSString *folderPath = [NSString stringWithFormat:@"%@/%@", destinationPath, folderName];
        if(![[NSFileManager defaultManager] fileExistsAtPath:folderPath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:folderPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
    }
    
    BOOL copied = NO, deleted = NO;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:originPath])
    {
        if([[NSFileManager defaultManager] copyItemAtPath:originPath toPath:destinationPath error:nil])
            copied = YES;
    }
    
    if(destination != DirectoryTypeMainBundle)
    {
        if([[NSFileManager defaultManager] fileExistsAtPath:originPath])
            if([[NSFileManager defaultManager] removeItemAtPath:originPath error:nil])
                deleted = YES;
    }
    
    if(copied && deleted)
        return YES;
    return NO;
}

+ (BOOL)duplicateFileAtPath:(NSString *)origin toNewPath:(NSString *)destination
{
    if([[NSFileManager defaultManager] fileExistsAtPath:origin])
        return [[NSFileManager defaultManager] copyItemAtPath:origin toPath:destination error:nil];
    return NO;
}

+ (BOOL)renameFileFromDirectory:(DirectoryType)origin atPath:(NSString *)path withOldName:(NSString *)oldName andNewName:(NSString *)newName
{
    NSString *originPath;
    
    switch(origin)
    {
        case DirectoryTypeMainBundle:
            originPath = [self getBundlePathForFile:path];
            break;
        case DirectoryTypeLibrary:
            originPath = [self getDocumentsDirectoryForFile:path];
            break;
        case DirectoryTypeDocuments:
            originPath = [self getLibraryDirectoryForFile:path];
            break;
        case DirectoryTypeCache:
            originPath = [self getCacheDirectoryForFile:path];
            break;
        default:
            break;
    }
    
    if([[NSFileManager defaultManager] fileExistsAtPath:originPath])
    {
        NSString *newNamePath = [originPath stringByReplacingOccurrencesOfString:oldName withString:newName];
        if([[NSFileManager defaultManager] copyItemAtPath:originPath toPath:newNamePath error:nil])
            if([[NSFileManager defaultManager] removeItemAtPath:originPath error:nil])
                return YES;
    }
    return NO;
}

+ (id)getSettings:(NSString *)settings objectForKey:(NSString *)objKey
{
    NSString *path = [self getLibraryDirectoryForFile:@""];
    path = [path stringByAppendingString:@"/Preferences/"];
    path = [path stringByAppendingString:[NSString stringWithFormat:@"%@-Settings.plist", settings]];
    
    NSMutableDictionary *loadedPlist;
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        loadedPlist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    }
    else
    {
        return nil;
    }
    
    return loadedPlist[objKey];
}

+ (BOOL)setSettings:(NSString *)settings object:(id)value forKey:(NSString *)objKey
{
    NSString *path = [self getLibraryDirectoryForFile:@""];
    path = [path stringByAppendingString:@"/Preferences/"];
    path = [path stringByAppendingString:[NSString stringWithFormat:@"%@-Settings.plist", settings]];
    
    NSMutableDictionary *loadedPlist;
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        loadedPlist = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    }
    else
    {
        loadedPlist = [[NSMutableDictionary alloc] init];
    }
    
    [loadedPlist setObject:value forKey:objKey];
    
    return [loadedPlist writeToFile:path atomically:YES];
}

+ (id)getAppSettingsForObjectWithKey:(NSString *)objKey
{
    return [self getSettings:APP_NAME objectForKey:objKey];
}

+ (BOOL)setAppSettingsForObject:(id)value forKey:(NSString *)objKey
{
    return [self setSettings:APP_NAME object:value forKey:objKey];
}


@end
