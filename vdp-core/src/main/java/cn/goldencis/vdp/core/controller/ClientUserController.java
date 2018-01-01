package cn.goldencis.vdp.core.controller;

import cn.goldencis.vdp.core.service.IDepartmentService;
import cn.goldencis.vdp.core.entity.ClientUserDO;
import cn.goldencis.vdp.core.entity.ClientUserDOCriteria;
import cn.goldencis.vdp.core.service.IClientUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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

    @RequestMapping(value = "/index")
    public ModelAndView index() {
        ModelAndView model = new ModelAndView();
        model.setViewName("/user/clientUser/index");

        //根据当前用户查询部门信息，放到模型中返回前端
        String zNodes = departmentService.getNodesByLogin();
        model.addObject("zNodes", zNodes);

        return model;
    }

    @ResponseBody
    @RequestMapping(value = "getAllClientUsers")
    public List<ClientUserDO> getAllClientUsers(int start, int length) {
        ClientUserDOCriteria example = new ClientUserDOCriteria();
        List<ClientUserDO> clientUsers = clientUserService.listPage(start, length, example);

        return clientUsers;
    }

}
