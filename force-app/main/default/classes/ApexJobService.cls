public with sharing class ApexJobService {

    private Id batchApexJobId;

    public static ApexJobService instance = new ApexJobService();

    public ApexJobService() {
        this.batchApexJobId = null;
    }

    public Id executeBatch() {
        this.batchApexJobId = Database.executeBatch(new IdleJob());
        return this.batchApexJobId;
    }

    public Id getBatchApexJobId() {
        return this.batchApexJobId;
    }

    public static ApexJobService getInstance() {
        return instance;
    }

    /**
     * Create a task with the given subject and return the Task ID.
     * If an `IdleJob` has not yet been executed, execute the job.
     *
     * @param subject
     *
     * @return Task ID
     */
    public Id submitAndExecute(String subject) {
        Task newTask = new Task(Subject = subject);
        insert newTask;

        if (this.batchApexJobId == null) {
            this.executeBatch();
        }

        return newTask.Id;
    }
}
