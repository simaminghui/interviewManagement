package controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Page {



    @RequestMapping("/")
    public String indexShow()
    {

        return "index";
    }
    @RequestMapping("/test")
    public String testShow()
    {

        return "test";
    }


    @RequestMapping("/teacher")
    public String teacherShow()
    {

        return "teacher";
    }

    @RequestMapping("/student")
    public String studentShow()
    {

        return "student";
    }
    @RequestMapping("/addNews")
    public String addNewsShow()
    {

        return "addNews";
    }

    @RequestMapping("/editorNews")
    public String editorNewsShow()
    {

        return "editorNews";
    }

}
