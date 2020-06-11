package controller;

import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import pojo.Member;
import service.MemberService;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

@Controller
public class StudentController {

    @Autowired
    private MemberService memberService;

    String imagePath="D:\\IDEAdaima\\Interview\\src\\main\\webapp\\images\\";
    String url="http://localhost:8078/images/";

    @RequestMapping("/student/list")
    @ResponseBody
    public JSONObject allStudent(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "30") int rows,String studentID)
    {

        if (studentID==null)
            return memberService.allStudent(page,rows);
        return memberService.ByStudentIDLike(studentID,page,rows);
    }


    @RequestMapping("/student/delete")
    @ResponseBody
    public JSONObject deleteStudent(String studentID)
    {

        return memberService.deleteStudent(studentID);
    }



    @RequestMapping("/student/update")
    @ResponseBody
    public JSONObject updateStudent(Member member)
    {

        return memberService.updateStudent(member);
    }


    @RequestMapping("/student/image")
    @ResponseBody
    public JSONObject imageStudent( MultipartFile uploadFile , String id,String ename) throws IOException {
        JSONObject result=new JSONObject();

        /** 判断文件是否成功上传*/
        if (uploadFile != null)
        {
            // 获取上传的文件名全称
            String fileName = uploadFile.getOriginalFilename();
            // 获取上传文件的后缀名
            String suffix = fileName.substring(fileName.lastIndexOf("."));

            /**前端*/
            upImage(uploadFile,imagePath,ename);


            Member member=new Member();
            member.setId(id);
            member.setImage(url+ename+suffix);
            /**修改数据库*/
            memberService.updateStudent(member);

            result.put("success",true);
        }
        else
        {
            result.put("error","强选择图片");
        }
        return result;
    }



    @RequestMapping("/student/add")
    @ResponseBody
    public JSONObject addStudent(Member member)
    {


        return memberService.addStudent(member);
    }

    /**上传图片*/
    public static boolean upImage(MultipartFile uploadFile, String path, String newName) throws IOException {
        /** 判断文件是否成功上传*/
        if (uploadFile != null) {


            // 获取上传的文件名全称
            String fileName = uploadFile.getOriginalFilename();
            // 获取上传文件的后缀名
            String suffix = fileName.substring(fileName.lastIndexOf("."));

            // 给文件定义一个新的名称,杜绝文件重名覆盖现象
            String newFileName = newName + suffix;

            // 创建File对象,注意这里不是创建一个目录或一个文件,你可以理解为是 获取指定目录中文件的管理权限(增改删除判断等 . . .)
            File tempFile = new File(path);


            // 判断File对象对应的目录是否存在
            if (!tempFile.exists()) {
                // 创建以此抽象路径名命名的目录,注意mkdir()只能创建一级目录,所以它的父级目录必须存在
                tempFile.mkdir();
            }

            // 将上传的文件写入指定文件
            uploadFile.transferTo(new File(path, newFileName));

            return true;
        }

        return false;

    }
}
