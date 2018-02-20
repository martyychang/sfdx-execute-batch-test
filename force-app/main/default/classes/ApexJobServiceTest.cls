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

    /**
     * This test is supposed to prove that `Database.executeBatch` is only
     * called once, even if `ApexJobService.submitAndExecute` is called
     * multiple times within the same Apex transaction.
     */
    @isTest
    private static void submitAndExecuteTwice() {

        // Given
        String subject = 'foo';

        ApexJobService apexJob = ApexJobService.getInstance();

        // When
        Test.startTest();

        Id firstTaskId = apexJob.submitAndExecute(subject);

        // Quick sanity check to make sure the Batch Apex Job ID
        // from the first call to `Database.executeBatch` was stored
        System.assertNotEquals(
                null, apexJob.getBatchApexJobId(),
                'Batch Apex Job ID');
        
        Id secondTaskId = apexJob.submitAndExecute(subject);

        // Then
        Test.stopTest();

        System.assertNotEquals(
                firstTaskId, secondTaskId,
                'Batch Apex Job ID');
    }
}
