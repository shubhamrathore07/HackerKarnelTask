/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 03-01-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
trigger RegisteredParticipants on Participant__c(before insert, before update, after insert, after update){
    if(Trigger.isAfter && Trigger.isInsert){
        List<Meeting__c> meetList = new List<Meeting__c>();
        Set<Id> meetingIds = new Set<Id>();

        for(Participant__c participant : Trigger.new){
            if(participant.Meeting__c != null){
                meetingIds.add(participant.Meeting__c);
            }
        }

        if(!meetingIds.isEmpty()){
            for(Meeting__c meet : [Select Id, (Select Id from Participants__r) from meeting__c Where Id IN :meetingIds]){
                meet.Registered_Participants__c = meet.Participants__r.size();
                meetList.add(meet);
            }if (!meetList.isEmpty()) {
                update meetList;
            }
        }
    }
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        List<Meeting__c> meetList = new List<Meeting__c>();
        Set<Id> meetingIds = new Set<Id>();

        for(Participant__c participant : Trigger.new){
            if(participant.Meeting__c != null){
                meetingIds.add(participant.Meeting__c);
        }
    }
    if(!meetingIds.isEmpty()){
        for(Meeting__c meet :[SELECT Id, Remaining_Capacity__c, Status__c FROM Meeting__c Where Id IN :meetingIds])
            if(meet.Remaining_Capacity__c != null && meet.Remaining_Capacity__c == 0){
            meet.Status__c = 'Full';
            meetList.add(meet);
        }
    }
    if(!meetList.isEmpty()){
        update meetList;
    }
}
}