public class CourseProfessorHandler {
    public static void rejectDuplicate(List<Course_Professor__c> triggerNew) {
        Set<id> profIds = new Set<id>();
        set<id> courseIds = new set<id>();

        for (Course_Professor__c cs : triggerNew) {
            profIds.add(cs.Professor__c);
            courseIds.add(cs.Course__c);
            
        }
        List<course_professor__c> existingCP = [select id, professor__c, Course__c from course_professor__c where professor__c in :profIds and course__c in :courseIds];

        Map<String, Course_professor__c> mapCP = new Map<String,Course_professor__c>();

        for (Course_professor__c crs : existingCP) {
            string key = crs.course__c + ' - ' + crs.professor__c;
            mapCP.put(key, crs);
        }

        for (Course_professor__c newCourse : triggerNew) {
            string key = newCourse.course__c + ' - ' +newCourse.Professor__c;
            if (mapCP.containsKey(key)) {
                newCourse.addError('Duplicate Alert!! Professor cannot book the same course');
            }
        }

    }
}
