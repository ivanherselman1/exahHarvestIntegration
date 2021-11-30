<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>License_Disk_is_Expiring_Soon</fullName>
        <ccEmails>nolene@exah.co.za</ccEmails>
        <description>License Disk is Expiring Soon (30 Days)</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Address__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>noreply@exah.co.za</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Licence_Disk_Email</template>
    </alerts>
    <alerts>
        <fullName>License_Disk_is_Expiring_Soon_14_Days</fullName>
        <ccEmails>nolene@exah.co.za</ccEmails>
        <description>License Disk is Expiring Soon (14 Days)</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Address__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>noreply@exah.co.za</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Licence_Disk_Email</template>
    </alerts>
    <rules>
        <fullName>Vehicle Licence Disk Expiring Soon</fullName>
        <actions>
            <name>License_Disk_is_Expiring_Soon</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>OR((Vehicle_1_Licence_Disk_Expiry_Date__c  = (TODAY() + 30)), 
			(Vehicle_1_Licence_Disk_Expiry_Date__c  = (TODAY() + 14)), 
			(Vehicle_2_Licence_Disk_Expiry_Date__c  = (TODAY() + 30)),
	(Vehicle_2_Licence_Disk_Expiry_Date__c  = (TODAY() + 14)),
	(Vehicle_3_Licence_Disk_Expiry_Date__c  = (TODAY() + 30)),
	(Vehicle_3_Licence_Disk_Expiry_Date__c  = (TODAY() + 14)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Vehicle Licence Disk Expiring Soon 14 Days</fullName>
        <active>false</active>
        <description>Vehicle Licence Disk Expiring Soon (14 Days)</description>
        <formula>OR((Vehicle_1_Licence_Disk_Expiry_Date__c  = (TODAY() + 14)), 
	(Vehicle_2_Licence_Disk_Expiry_Date__c  = (TODAY() + 14)),
	(Vehicle_3_Licence_Disk_Expiry_Date__c  = (TODAY() + 14)))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>License_Disk_is_Expiring_Soon_14_Days</name>
                <type>Alert</type>
            </actions>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
