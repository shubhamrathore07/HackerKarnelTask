/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-01-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class MeetingController {
    @AuraEnabled(cacheable=true)
    public static List<Meeting__c> getMeetings() {
        return [SELECT Id, Name, Meeting_Date__c, Location__c, Capacity__c, Registered_Participants__c, Remaining_Capacity__c, Status__c 
        FROM Meeting__c ORDER BY Meeting_Date__c DESC];
    }
}