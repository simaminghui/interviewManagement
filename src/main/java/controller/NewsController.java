package controller;


import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.News;
import service.NewsService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
public class NewsController {


    @Autowired
    private NewsService newsService;

    /**添加新闻*/
    @RequestMapping("/news/addNews")
    @ResponseBody
    public JSONObject addNews(News news)
    {
        return newsService.addNews(news);
    }


    @RequestMapping("/news/list")
    @ResponseBody
    public JSONObject allNews(@RequestParam(defaultValue = "1") int page, @RequestParam(defaultValue = "30") int rows)
    {

            return newsService.allNews(page,rows);
    }

    @RequestMapping("/news/delete")
    @ResponseBody
    public JSONObject deleteNews(Integer id)
    {

        return newsService.deleteNews(id);
    }


    @RequestMapping("/news/update")
    @ResponseBody
    public JSONObject newsUpdate(News news) {


        return newsService.newsUpdate(news);
    }



    @RequestMapping("/news/{id}")
    public String newsTipShow(@PathVariable("id") Integer id,Model model)
    {
        News news = newsService.getNewsById(id);
        model.addAttribute("news",news);
        return "tipNews";
    }
}
