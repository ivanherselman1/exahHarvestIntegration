<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Documents_Expiring_Soon</fullName>
        <ccEmails>nolene@exah.co.za</ccEmails>
        <description>Documents Expiring Soon</description>
        <protected>false</protected>
        <recipients>
            <field>Email_Address__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Secondary_Email_Address__c</field>
            <type>email</type>
        </recipients>
        <senderAddress>noreply@exah.co.za</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>unfiled$public/Expiring_Document_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Clear_Trigger_Date_Field</fullName>
        <field>Trigger_Date__c</field>
        <name>Clear Trigger Date Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reset_Trigger_Date</fullName>
        <field>Trigger_Date__c</field>
        <name>Reset Trigger Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_to_the_Trigger_Date</fullName>
        <field>Trigger_Date__c</field>
        <formula>TODAY()</formula>
        <name>Set to the Trigger Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Document Expiring Date</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Employee_Expiring_Documents__c.Issue_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Employee_Expiring_Documents__c.Expiry_Date__c</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Set_to_the_Trigger_Date</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employee_Expiring_Documents__c.Expiry_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Set_to_the_Trigger_Date</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employee_Expiring_Documents__c.Expiry_Date__c</offsetFromField>
            <timeLength>-14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Set_to_the_Trigger_Date</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employee_Expiring_Documents__c.Expiry_Date__c</offsetFromField>
            <timeLength>-60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Document Notifications 5</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Employee_Expiring_Documents__c.Expiry_Date__c</field>
            <operation>greaterThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Set_to_the_Trigger_Date</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employee_Expiring_Documents__c.Expiry_Date__c</offsetFromField>
            <timeLength>-60</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Set_to_the_Trigger_Date</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employee_Expiring_Documents__c.Expiry_Date__c</offsetFromField>
            <timeLength>-30</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
        <workflowTimeTriggers>
            <actions>
                <name>Set_to_the_Trigger_Date</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Employee_Expiring_Documents__c.Expiry_Date__c</offsetFromField>
            <timeLength>-14</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Notification Sent</fullName>
        <actions>
            <name>Documents_Expiring_Soon</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Reset_Trigger_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employee_Expiring_Documents__c.Trigger_Date__c</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
