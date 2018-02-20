/**
 * This job doesn't really do anything other than to be executable
 */
global class IdleJob implements Database.Batchable<SObject> {

    global void execute(
            Database.BatchableContext context, List<SObject> records) {
        /* do nothing */
    }

    global void finish(Database.BatchableContext context) {
        /* do nothing */
    }
    
    global Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([
            SELECT Id
            FROM Task
            WHERE Status = 'Not Started'
        ]);
    }
}
