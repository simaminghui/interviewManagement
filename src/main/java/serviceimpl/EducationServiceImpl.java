package serviceimpl;

import dao.EducationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Education;
import pojo.EducationExample;
import service.EducationService;

import java.util.List;

@Service
public class EducationServiceImpl implements EducationService {

    @Autowired
    private EducationMapper educationMapper;

    public List<Education> ByID(String ID) {
        EducationExample example=new EducationExample();
        example.createCriteria().andIdEqualTo(ID);

        return educationMapper.selectByExample(example);
    }
}
