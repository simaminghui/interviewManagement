package controller;


import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import pojo.Education;
import pojo.Member;
import pojo.Teacher;
import service.EducationService;
import service.TeacherService;

import java.io.IOException;
import java.util.List;

@Controller
public class TeacherController {

    @Autowired
    private TeacherService teacherService;
    @Autowired
    private EducationService educationService;

    String imagePath="D:\\IDEAdaima\\Interview\\src\\main\\webapp\\images\\";
    String url="http://localhost:8078/images/";
    @RequestMapping("/teacherTip/{id}")
    @ResponseBody
    public JSONObject getTeacherTip(@PathVariable ("id") String ID)
    {


        /**老师基本信息*/
        Teacher teachers = teacherService.ById(ID);
        /**教育经历*/
        List<Education> educations = educationService.ByID(ID);

        JSONObject result=new JSONObject();
        result.put("teachers",teachers);
        result.put("educations",educations);


        System.out.println(result);
        return result;
    }


    /**所有老师*/
    @RequestMapping("/teacher/list")
    @ResponseBody
    public JSONObject allTeachers(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "30") int rows, String teacherID)
    {


            return teacherService.allTeacher(page,rows);

    }

    /**查询教育信息*/
    @RequestMapping("/teacher/education")
    @ResponseBody
    public List<Education> getEducation(String id)
    {
        System.out.println(id);
        return teacherService.getEducation(id);
    }


    /**删除*/
    @RequestMapping("teacher/delete")
    @ResponseBody
    public JSONObject teacherDeleteByPrimaryKey(String id)
    {



        JSONObject result=new JSONObject();

        teacherService.teacherDeleteByPrimaryKey(id);
        result.put("success",true);
        return result;

    }


    /**修改信息*/
    @RequestMapping("/teacher/update")
    @ResponseBody
    public JSONObject teacherUpdate(Teacher teacher)
    {



        JSONObject result=new JSONObject();

        teacherService.teacherUpdateByPrimaryKey(teacher);
        result.put("success",true);
        return result;

    }


    /**添加照片*/
    @RequestMapping("/teacher/image")
    @ResponseBody
    public JSONObject imageTeacher(MultipartFile uploadFile , String id, String ename) throws IOException {
        JSONObject result=new JSONObject();

        /** 判断文件是否成功上传*/
        if (uploadFile != null)
        {
            // 获取上传的文件名全称
            String fileName = uploadFile.getOriginalFilename();
            // 获取上传文件的后缀名
            String suffix = fileName.substring(fileName.lastIndexOf("."));

            /**前端*/
            StudentController.upImage(uploadFile,imagePath,ename);


            Teacher teacher=new Teacher();
            teacher.setId(id);
            teacher.setImage(url+ename+suffix);
            /**修改数据库*/
            teacherService.updateTeacher(teacher);

            result.put("success",true);
        }
        else
        {
            result.put("error","强选择图片");
        }
        return result;
    }


    /**添加老师*/
    @RequestMapping("/teacher/save")
    @ResponseBody
    public JSONObject teacherSave(Teacher teacher)
    {




        return  teacherService.addSave(teacher);


    }
}
