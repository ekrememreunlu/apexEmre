@IsTest
private class CourseProfessorHandlerTest {
    @TestSetup
    static void prepareData(){
        Admission_Officer__c officer = new Admission_Officer__c(Name= 'Test Officer',
        Email__c = 'testemail@test.com', Phone__c = '004353453543');
        insert officer;

        Course__c course = new Course__c(admission_officer__c = officer.id, Name = 'Test course', Start_Date_Time__c = datetime.now().addDays(1), Max_Seats__c = 10
        );

        insert course;

        Professor__c prof = new Professor__c(Name = 'Test Proffesor', Email__c = 'testprof@test.com', phone__c = '09809340953');

        insert prof;

        Course_Professor__c courseProf = new Course_Professor__c(course__c = course.id, professor__c = prof.id);

        insert courseProf;


    }

    @isTest
    static void testError(){
        Course_Professor__c testData = [select course__c, Professor__c from Course_Professor__c limit 1];
        Course_Professor__c cp = new Course_Professor__c();
        cp.course__c = testData.course__c;
        cp.professor__c = testData.professor__c;

        test.startTest();
        Database.SaveResult sr = Database.insert(cp, false);
        test.stopTest();
        
        assert.isFalse(sr.isSuccess());
        string msg = sr.getErrors().get(0).getMessage();
        assert.areEqual('Duplicate Alert!! Professor cannot book the same course', msg);

    }
   
}
