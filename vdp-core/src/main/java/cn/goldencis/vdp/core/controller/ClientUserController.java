package cn.goldencis.vdp.core.controller;

import cn.goldencis.vdp.core.constants.ConstantsDto;
import cn.goldencis.vdp.core.entity.DepartmentDO;
import cn.goldencis.vdp.core.entity.ResultMsg;
import cn.goldencis.vdp.core.service.IDepartmentService;
import cn.goldencis.vdp.core.entity.ClientUserDO;
import cn.goldencis.vdp.core.service.IClientUserService;
import cn.goldencis.vdp.core.utils.GetLoginUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import java.util.List;

/**
 * Created by limingchao on 2017/12/22.
 */
@Controller
@RequestMapping(value = "/clientUser")
public class ClientUserController implements ServletContextAware {

    @Autowired
    private IClientUserService clientUserService;

    @Autowired
    private IDepartmentService departmentService;

    private ServletContext servletContext;

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    /**
     * 用户管理主页面
     *
     * @return
     */
    @RequestMapping(value = "/index")
    public ModelAndView index() {
        ModelAndView model = new ModelAndView();
        model.setViewName("/user/clientUser/index");

        //根据当前用户查询部门信息，放到模型中返回前端
        String zNodes = departmentService.getNodesByLogin();
        model.addObject("zNodes", zNodes);

        return model;
    }

    /**
     * 请求指定部门下的用户列表
     *
     * @param pid       指定部门id
     * @param start
     * @param length
     * @param ordercase 查询条件
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getClientUserPageByDepartmentId")
    public ResultMsg getAllClientUsers(@RequestParam(defaultValue = "1") Integer pid, int start, int length, @RequestParam(value = "draw", required = false) String draw, @RequestParam(value = "ordercase", required = false) String ordercase) {

        //根据部门参数不同查询部门集合，当部门id为顶级部门时，需要判断账户部门权限，
        List<DepartmentDO> departmentList = null;
        //重新查询账户的关联部门，查询其部门权限集合，如果包含顶级部门，则查询查询全部部门，否则查询该账户部门权限下的部门
        if (pid == 1) {
            departmentList = GetLoginUser.getDepartmentListWithLoginUser();
        } else {
            //如果不是顶级部门，查询该部门下所有部门的集合
            departmentList = departmentService.getDeptarMentListByParent(pid);
        }

        ResultMsg resultMsg = new ResultMsg();
        if (departmentList != null && departmentList.size() > 0) {
            int conut = (int) clientUserService.conutClientUserListByDepartmentId(departmentList);
            List<ClientUserDO> clientUsers = clientUserService.getClientUserListByDepartmentId(departmentList, start, length);
            resultMsg.setData(clientUsers);
            resultMsg.setExportlength(length);
            resultMsg.setExportstart(start);
            resultMsg.setRecordsFiltered(conut);
            resultMsg.setRecordsTotal(conut);
            resultMsg.setResultCode(ConstantsDto.RESULT_CODE_TRUE);
            return resultMsg;
        }

        return resultMsg;
    }

    @ResponseBody
    @RequestMapping(value = "/addClientUser", method = RequestMethod.POST)
    public ResultMsg addClientUser(ClientUserDO clientUser) {

        ResultMsg resultMsg = new ResultMsg();
        try {
            //判断用户名是否重复
            boolean flag = clientUserService.checkClientUserNameDuplicate(clientUser.getUsername());
            if (!flag) {
                resultMsg.setResultCode(ConstantsDto.RESULT_CODE_FALSE);
                resultMsg.setResultMsg("用户名重复！");
                return resultMsg;
            }

            //插入用户
            clientUserService.addClientUser(clientUser);
            resultMsg.setResultCode(ConstantsDto.RESULT_CODE_TRUE);
            resultMsg.setResultMsg("插入成功！");
        } catch (Exception e) {
            resultMsg.setResultCode(ConstantsDto.RESULT_CODE_ERROR);
            resultMsg.setResultMsg("插入错误");
        }
        return resultMsg;
    }

    @ResponseBody
    @RequestMapping(value = "/updateClientUser", method = RequestMethod.POST)
    public ResultMsg updateClientUser(ClientUserDO clientUser) {
        ResultMsg resultMsg = new ResultMsg();
        try {
            //判断用户名是否重复
            boolean flag = clientUserService.checkClientUserNameDuplicate(clientUser.getUsername());
            if (!flag) {
                resultMsg.setResultCode(ConstantsDto.RESULT_CODE_FALSE);
                resultMsg.setResultMsg("用户名重复！");
                return resultMsg;
            }

            clientUserService.updateClientUser(clientUser);
            resultMsg.setResultCode(ConstantsDto.RESULT_CODE_TRUE);
            resultMsg.setResultMsg("更新成功！");
        } catch (Exception e) {
            resultMsg.setResultCode(ConstantsDto.RESULT_CODE_ERROR);
            resultMsg.setResultMsg("更新异常");
        }
        return resultMsg;
    }

    @ResponseBody
    @RequestMapping(value = "/deleteClientUser",method = RequestMethod.POST)
    public ResultMsg deleteClientUser(Integer id) {
        ResultMsg resultMsg = new ResultMsg();

        try {
            clientUserService.deleteClientUserById(id);
            resultMsg.setResultCode(ConstantsDto.RESULT_CODE_TRUE);
            resultMsg.setResultMsg("删除成功！");
        } catch (Exception e) {
            resultMsg.setResultCode(ConstantsDto.RESULT_CODE_ERROR);
            resultMsg.setResultMsg("删除错误！");
        }
        resultMsg.setResultCode(1);
        return resultMsg;
    }

}
