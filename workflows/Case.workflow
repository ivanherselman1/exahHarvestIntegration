<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>New_Case_Email</fullName>
        <description>New Case Email</description>
        <protected>false</protected>
        <recipients>
            <field>Assign_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Case_Assigned_To_You</template>
    </alerts>
    <rules>
        <fullName>New Case Assigned To You</fullName>
        <actions>
            <name>New_Case_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Assign_To__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>To notify the individuals of cases assigned to them.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
