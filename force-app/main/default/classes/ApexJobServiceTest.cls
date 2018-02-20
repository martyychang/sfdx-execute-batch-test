@isTest
private class ApexJobServiceTest {

    @isTest
    private static void submitAndExecute() {

        // Given
        String subject = 'foo';

        ApexJobService apexJob = ApexJobService.getInstance();

        // When
        Test.startTest();

        Id taskId = apexJob.submitAndExecute(subject);

        // Then
        Test.stopTest();

        System.assertNotEquals(
                null, apexJob.getBatchApexJobId(),
                'Batch Apex Job ID');
    }
}
