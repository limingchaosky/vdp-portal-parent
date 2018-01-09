package cn.goldencis.vdp.core.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import cn.goldencis.vdp.core.entity.ResultMsg;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.goldencis.vdp.core.entity.NetConfigDO;
import cn.goldencis.vdp.core.entity.NetConfigsForm;
import cn.neiwang.tsajni.IFConfig;

@Controller
@RequestMapping("/netconfig")
public class NetConfigController {





    @ResponseBody
    @RequestMapping(value = "/configTest")
    public ResultMsg configTest() {
        ResultMsg resultMsg = new ResultMsg();
        try {
            String ifConfig = IFConfig.getIFConfig();
            resultMsg.setData(ifConfig);
        } catch (Exception e) {
            e.printStackTrace();
            resultMsg.setData(e);
        }
        return resultMsg;
    }
}
