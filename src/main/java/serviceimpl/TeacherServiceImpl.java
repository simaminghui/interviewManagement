package serviceimpl;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dao.EducationMapper;
import dao.TeacherMapper;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Education;
import pojo.EducationExample;
import pojo.Teacher;
import pojo.TeacherExample;
import service.TeacherService;

import java.util.List;

@Service
public class TeacherServiceImpl implements TeacherService{

    @Autowired
    private TeacherMapper teacherMapper;
    @Autowired
    private EducationMapper educationMapper;

    /**得到老师*/
    public List<Teacher> getTeacher() {


        TeacherExample example=new TeacherExample();
        return teacherMapper.selectByExample(example);
    }

    public Teacher ById(String ID) {
        return teacherMapper.selectByPrimaryKey(ID);
    }


    /**所有老师*/
    public JSONObject allTeacher(int page, int rows) {
        PageHelper.startPage(page,rows);
        TeacherExample example=new TeacherExample();
        List<Teacher> teachers=teacherMapper.selectByExample(example);
        PageInfo<Teacher> info=new PageInfo<Teacher>(teachers);
        JSONObject result=new JSONObject();
        result.put("total",info.getTotal());
        result.put("rows",teachers);
        return result;
    }

    public List<Education> getEducation(String id) {

        EducationExample example=new EducationExample();
        example.createCriteria().andIdEqualTo(id);
        return educationMapper.selectByExample(example);
    }

    public void teacherDeleteByPrimaryKey(String id) {
        /**数据库删除*/
        teacherMapper.deleteByPrimaryKey(id);


        /**删除教育背景*/
       EducationExample example=new EducationExample();
        example.createCriteria().andIdEqualTo(id);
        educationMapper.deleteByExample(example);

    }

    public void teacherUpdateByPrimaryKey(Teacher teacher) {
        TeacherExample example=new TeacherExample();
        example.createCriteria().andIdEqualTo(teacher.getId());


        /**修改数据库*/
        teacherMapper.updateByExampleSelective(teacher,example);



    }

    public JSONObject updateTeacher(Teacher teacher) {
        JSONObject result=new JSONObject();
        /**数据库修改*/
        teacherMapper.updateByPrimaryKeySelective(teacher);

        result.put("success",true);
        return result;
    }

    public JSONObject addSave(Teacher teacher) {
        JSONObject result=new JSONObject();

        Teacher teacher1 = teacherMapper.selectByPrimaryKey(teacher.getId());
        //存在该老师
        if (teacher1!=null) {
            result.put("success", false);
            result.put("error", "编号存在，重新输入");

        }
        else //添加
        {


            //添加到数据库
            teacherMapper.insert(teacher);
            result.put("success",true);
        }
        return result;
    }
}
