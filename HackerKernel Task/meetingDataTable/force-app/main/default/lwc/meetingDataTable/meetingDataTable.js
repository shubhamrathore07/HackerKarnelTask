import getMeetings from '@salesforce/apex/MeetingController.getMeetings';
import { LightningElement, wire } from 'lwc';

export default class MeetingDataTable extends LightningElement {
    meetings;
    error;
    
    
    columns = [
        { label: 'Meeting Name', fieldName: 'Name' },
        { label: 'Meeting Date', fieldName: 'Meeting_Date__c', type: 'date' },
        { label: 'Location', fieldName: 'Location__c' },
        { label: 'Capacity', fieldName: 'Capacity__c', type: 'number' },
        { label: 'Registered Participants', fieldName: 'Registered_Participants__c', type: 'number' },
        { label: 'Remaining Capacity', fieldName: 'Remaining_Capacity__c', type: 'number' },
        { label: 'Status', fieldName: 'Status__c' }
    ];

    
    @wire(getMeetings)
    wiredMeetings({ error, data }) {
        if (data) {
            this.meetings = data;
            this.error = undefined;
        } else if (error) {
            this.error = error.body.message || 'Unknown error';
            this.meetings = undefined;
        }
    }
}