<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_that_sends_when_Leads_are_lost</fullName>
        <description>Email that sends when Leads are lost</description>
        <protected>false</protected>
        <recipients>
            <recipient>elicus@exahza.co.za</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>exah@exahza.co.za</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>izak@exahza.co.za</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>lochner@exahza.co.za</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>wian@exahza.co.za</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Support_test</template>
    </alerts>
</Workflow>
