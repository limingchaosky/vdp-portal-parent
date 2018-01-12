package cn.goldencis.vdp.core.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.goldencis.vdp.core.entity.ResultMsg;
import cn.goldencis.vdp.core.entity.UserDO;
import cn.goldencis.vdp.core.service.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;

import cn.goldencis.vdp.common.cache.manager.GuavaCacheManager;
import cn.goldencis.vdp.common.utils.CommonPoiXsl;
import cn.goldencis.vdp.common.utils.DateUtil;
import cn.goldencis.vdp.common.utils.FileDownLoad;
import cn.goldencis.vdp.common.utils.StringUtil;
import cn.goldencis.vdp.core.constants.ConstantsDto;
import cn.goldencis.vdp.core.entity.DepartmentDO;
import cn.goldencis.vdp.core.utils.AuthUtils;
import cn.goldencis.vdp.core.utils.GetLoginUser;
import cn.goldencis.vdp.core.utils.JsonUtil;
import cn.goldencis.vdp.core.utils.PathConfig;

/**
 * 管理员管理controller
 *
 * @author Administrator
 */
@Controller
@RequestMapping("/systemSetting/user")
public class UserController implements ServletContextAware {

    @Autowired
    private IUserService userService;

    @Autowired
    private GuavaCacheManager cacheManager;

    private static final String FILE_NAME = "用户信息";

    private ServletContext servletContext;

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    /**
     * 根据登录用户的角色类型，获取相应类型的账户列表。分页查询
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getUserPages")
    public ResultMsg getUserPages(@RequestParam("start") int start, @RequestParam("length") int length) {
        ResultMsg resultMsg = new ResultMsg();
        int count = 0;
        try {
            //获取当前登录用户
            UserDO user = GetLoginUser.getLoginUser();

            //根据登录用户的角色类型，获取相应类型的账户列表。分页查询
            List<UserDO> userList = userService.getUserListByLoginUserRoleTypeInPages(user, start, length);
            count = userService.countUserListByLoginUserRoleTypeInPages(user);

            resultMsg.setData(userList);
            resultMsg.setResultMsg("用户列表获取成功！");
            resultMsg.setResultCode(ConstantsDto.RESULT_CODE_TRUE);
        } catch (Exception e) {
            resultMsg.setResultMsg("用户列表获取错误！");
            resultMsg.setResultCode(ConstantsDto.RESULT_CODE_ERROR);
            resultMsg.setData(e);
        }
        resultMsg.setExportstart(start);
        resultMsg.setExportlength(length);
        resultMsg.setRecordsFiltered(count);
        resultMsg.setRecordsTotal(count);

        return resultMsg;
    }

    /**
     * 新建和更新接口
     * @param user
     * @param departmentListStr
     * @param navigationListStr
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/addOrUpdateUser", method = RequestMethod.POST)
    public ResultMsg addOrUpdateUser(UserDO user, String departmentListStr, String navigationListStr) {
        ResultMsg resultMsg = new ResultMsg();
        try {
            //检查账户名是否重复
            boolean flag = userService.checkUserNameDuplicate(user);

            if (!flag) {
                resultMsg.setResultCode(ConstantsDto.RESULT_CODE_FALSE);
                resultMsg.setResultMsg("账户名重复！");
                return resultMsg;
            }

            if (StringUtil.isEmpty(user.getPassword())) {
                user.setPassword(null);
            }
            userService.addOrUpdateUser(user, departmentListStr, navigationListStr);

            resultMsg.setResultMsg("账户更改成功！");
            resultMsg.setResultCode(ConstantsDto.RESULT_CODE_TRUE);
        } catch (Exception e) {
            resultMsg.setResultMsg("账户更改错误！");
            resultMsg.setResultCode(ConstantsDto.RESULT_CODE_ERROR);
            resultMsg.setData(e);
        }

        return resultMsg;
    }

    @ResponseBody
    @RequestMapping(value = "/deleteUser", method = RequestMethod.POST)
    public ResultMsg deleteUser(Integer userId) {
        ResultMsg resultMsg = new ResultMsg();
        try {
            UserDO user = userService.getUserByUserId(userId);
            if (user == null) {
                resultMsg.setResultMsg("不存在此账户！");
                resultMsg.setResultCode(ConstantsDto.RESULT_CODE_FALSE);
            } else {
                userService.deleteUser(user);
                resultMsg.setResultMsg("账户删除成功！");
                resultMsg.setResultCode(ConstantsDto.RESULT_CODE_TRUE);
            }
        } catch (Exception e) {
            resultMsg.setResultMsg("账户删除错误！");
            resultMsg.setResultCode(ConstantsDto.RESULT_CODE_ERROR);
            resultMsg.setData(e);
        }

        return resultMsg;
    }

    /**
     * 根据当前登录账户的角色类型，获取同角色类型的所有账户并返回。
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/getUserListByLoginUserRoleType")
    public String getUserListByLoginUserRoleType() {

        UserDO user = GetLoginUser.getLoginUser();
        List<UserDO> userList;

        if ("1".equals(user.getGuid())) {
            userList = userService.getAllUser();
        } else {
            Integer roleType = user.getRoleType();
            userList = userService.getUserListByLoginUserRoleType(roleType);
        }


        String userListStr = JsonUtil.getObjectToString(userList);
        return userListStr;
    }

    @ResponseBody
    @RequestMapping(value = "/exportxslall", method = RequestMethod.GET)
    public void exportXslAll(UserDO user, HttpServletRequest request, HttpServletResponse response) {

        List<UserDO> dlist = userService.getUserList(user);
        CommonPoiXsl<UserDO> poiXsl = new CommonPoiXsl<UserDO>();
        String path = "";
        try {
            String key = DateUtil.format(new Date(), "yyyyMMddHHmmss");
            path = PathConfig.HOM_PATH + "/tomcat/webapps/export/";
            if (!(new File(path).isDirectory())) {
                new File(path).mkdirs();
            }
            path = path + FILE_NAME + key + ".xls";
            OutputStream out = new FileOutputStream(path);
            String[] headers = {"账户名称", "管辖部门", "角色", "真实姓名", "电话", "邮箱"};
            poiXsl.exportExcel("用户信息", headers, dlist, out, "yyyy-MM-dd");
            out.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        FileDownLoad filedownload = new FileDownLoad();
        filedownload.download(response, request, path);
    }

    @ResponseBody
    @RequestMapping(value = "/insertRefusePromptUser", produces = "application/json", method = RequestMethod.POST)
    public Map<String, Object> insertRefusePromptUser(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("resultCode", ConstantsDto.CONST_FALSE);
        try {
            UserDO user = GetLoginUser.getLoginUser();
            userService.insertRefusePromptUser(user.getGuid());
            resultMap.put("resultCode", ConstantsDto.CONST_TRUE);
        } catch (Exception e) {
        }

        return resultMap;
    }
}
