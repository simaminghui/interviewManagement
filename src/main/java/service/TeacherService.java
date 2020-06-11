package service;

import net.sf.json.JSONObject;
import pojo.Education;
import pojo.Teacher;

import java.util.List;

public interface TeacherService {

    List<Teacher> getTeacher();
    Teacher ById(String ID);

    JSONObject allTeacher(int page, int rows);

    List<Education> getEducation(String id);

    void teacherDeleteByPrimaryKey(String id);

    void teacherUpdateByPrimaryKey(Teacher teacher);

    JSONObject updateTeacher(Teacher teacher);

    JSONObject addSave(Teacher teacher);
}
