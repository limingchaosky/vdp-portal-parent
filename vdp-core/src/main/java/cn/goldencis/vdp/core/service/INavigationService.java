package cn.goldencis.vdp.core.service;

import java.util.List;

import cn.goldencis.vdp.core.entity.NavigationDO;
import cn.goldencis.vdp.core.entity.UserDO;
import com.alibaba.fastjson.JSONArray;

public interface INavigationService {

    List<NavigationDO> getUserNavigation(UserDO user);

    String getNavigation();

    /**
     * 通过账户的角色类型，查询对应的页面集合
     * @param roleType
     * @return
     */
    JSONArray getNavigationListByRoleType(Integer roleType);
}
