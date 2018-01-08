package cn.goldencis.vdp.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by limingchao on 2018/1/8.
 */
@Controller
@RequestMapping(value = "/systemClient")
public class ClientController {

    @RequestMapping(value = "/index")
    public ModelAndView index() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("system/client/index");
        return modelAndView;
    }

}
