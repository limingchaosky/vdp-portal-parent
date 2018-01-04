package cn.goldencis.vdp.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by limingchao on 2018/1/4.
 */
@Controller
@RequestMapping(value = "/report")
public class ReportController {

    @RequestMapping(value = "/index")
    public ModelAndView index() {
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("report/index");
        return modelAndView;
    }

}
