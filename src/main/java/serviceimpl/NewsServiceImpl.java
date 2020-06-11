package serviceimpl;

import Tools.DateTime;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dao.NewsMapper;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Member;
import pojo.MemberExample;
import pojo.News;
import pojo.NewsExample;
import service.NewsService;

import java.util.List;

@Service
public class NewsServiceImpl implements NewsService {

    @Autowired
    private NewsMapper newsMapper;

    /**得到新闻*/
    public List<News> allNews() {
        NewsExample example=new NewsExample();
        return newsMapper.selectByExample(example);
    }

    public News getNewsById(Integer id) {
        News news = newsMapper.selectByPrimaryKey(id);
        return news;
    }

    public JSONObject addNews(News news) {


        news.setTime(DateTime.DateToString());
        newsMapper.insertSelective(news);
        return null;
    }

    public JSONObject allNews(int page, int rows) {
        PageHelper.startPage(page,rows);
        NewsExample example=new NewsExample();
        example.setOrderByClause("time DESC");
        List<News> news =newsMapper.selectByExample(example);
        PageInfo<News> info=new PageInfo<News>(news);
        JSONObject result=new JSONObject();
        result.put("total",info.getTotal());
        result.put("rows",news);

        return result;
    }

    public JSONObject deleteNews(Integer id) {

        newsMapper.deleteByPrimaryKey(id);
        JSONObject result=new JSONObject();
        result.put("success",true);
        return result;
    }

    public JSONObject newsUpdate(News news) {
        newsMapper.updateByPrimaryKeySelective(news);
        return null;
    }
}
