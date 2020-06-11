package serviceimpl;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dao.MemberMapper;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import pojo.Member;
import pojo.MemberExample;
import service.MemberService;

import java.util.ArrayList;
import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper memberMapper;



    /**得到博士生*/
    public List<Member> getDoctor(Integer isGraduate) {

        MemberExample example=new MemberExample();
        MemberExample.Criteria criteria=example.createCriteria();

        /**已经毕业*/
        if (isGraduate==1)
        {
            criteria.andGraduateEqualTo(isGraduate);
        }
        else
        {
            /**没有毕业*/
            criteria.andGraduateEqualTo(isGraduate);
        }
        /**博士*/
        criteria.andStatusEqualTo(1);

        List<Member> members = memberMapper.selectByExample(example);

        return members;
    }

    public List<Member> getGraduation(Integer isGraduate) {


        MemberExample example=new MemberExample();
        MemberExample.Criteria criteria=example.createCriteria();

        /**已经毕业*/
        if (isGraduate==1)
        {
            criteria.andGraduateEqualTo(isGraduate);
        }
        else
        {
            /**没有毕业*/
            criteria.andGraduateEqualTo(isGraduate);
        }
        /**研究生*/
        criteria.andStatusEqualTo(2);

        List<Member> members = memberMapper.selectByExample(example);

        return members;
    }

    public JSONObject allStudent(int page, int rows) {
        PageHelper.startPage(page,rows);
        MemberExample example=new MemberExample();
        List<Member> members =memberMapper.selectByExample(example);
        PageInfo<Member> info=new PageInfo<Member>(members);
        JSONObject result=new JSONObject();
        result.put("total",info.getTotal());
        result.put("rows",members);

        return result;
    }

    public JSONObject ByStudentIDLike(String studentID, int page, int rows) {
        MemberExample example=new MemberExample();
        MemberExample.Criteria criteria=example.createCriteria();
        criteria.andIdLike("%"+studentID+"%");

        List<Member> members = memberMapper.selectByExample(example);

        List<Member> members1=new ArrayList<Member>();
        for (int i=(page-1)*rows;i<page*rows;i++)
            if (i<members.size())
                members1.add(members.get(i));
            else
                break;

        JSONObject result=new JSONObject();
        result.put("total",members.size());
        result.put("rows",members1);
        return result;
    }

    public JSONObject deleteStudent(String studentID) {

        memberMapper.deleteByPrimaryKey(studentID);
        JSONObject result=new JSONObject();
        result.put("success",true);
        return result;
    }

    public JSONObject updateStudent(Member member) {
        JSONObject result=new JSONObject();
        /**数据库修改*/
        memberMapper.updateByPrimaryKeySelective(member);

        result.put("success",true);
        return result;
    }

    public JSONObject addStudent(Member member) {

        JSONObject result=new JSONObject();
        Member student1 = memberMapper.selectByPrimaryKey(member.getId());
        if (student1==null)
        {

            /**添加数据库*/
            memberMapper.insertSelective(member);


            result.put("success",true);
        }
        else
        {
            result.put("error","学生ID存在，请重新添加");
        }

        return result;
    }


}
