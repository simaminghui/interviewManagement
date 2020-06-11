package service;

import net.sf.json.JSONObject;
import pojo.News;

import java.util.List;

public interface NewsService {
    
    News getNewsById(Integer id);

    JSONObject addNews(News news);

    JSONObject allNews(int page, int rows);

    JSONObject deleteNews(Integer id);

    JSONObject newsUpdate(News news);
}
