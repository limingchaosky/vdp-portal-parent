package cn.goldencis.vdp.example.controller;

import cn.goldencis.vdp.core.service.IDepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by limingchao on 2018/1/5.
 */
@Controller
@RequestMapping(value = "/systemSetting/index")
public class SystemController {

    @Autowired
    private IDepartmentService departmentService;

    @RequestMapping(value = "")
    public ModelAndView index() {
        ModelAndView modelAndView = new ModelAndView();
        String zNodes = departmentService.getNodesByLogin();
        modelAndView.addObject("zNodes",zNodes);
        modelAndView.setViewName("system/setting/index");
        return modelAndView;
    }

}
