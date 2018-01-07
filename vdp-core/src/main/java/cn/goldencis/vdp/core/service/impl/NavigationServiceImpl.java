package cn.goldencis.vdp.core.service.impl;

import java.util.ArrayList;
import java.util.List;

import cn.goldencis.vdp.core.dao.*;
import cn.goldencis.vdp.core.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.goldencis.vdp.common.dao.BaseDao;
import cn.goldencis.vdp.common.service.impl.AbstractBaseServiceImpl;
import cn.goldencis.vdp.core.service.INavigationService;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/**
 * 菜单及顶部service实现类
 *
 * @author Administrator
 */
@Component("navigationService")
public class NavigationServiceImpl extends AbstractBaseServiceImpl<NavigationDO, NavigationDOCriteria> implements INavigationService {

    @Autowired
    private NavigationDOMapper mapper;

    @Autowired
    private PermissionNavigationDOMapper permissionNavigationDOMapper;

    @Autowired
    private CPermissionNavigationDOMapper cpermissionNavigationDOMapper;

    @Autowired
    private UserDOMapper userDOMapper;

    @Autowired
    private UserPermissionDOMapper userPermissionDOMapper;

    @SuppressWarnings("unchecked")
    @Override

    protected BaseDao<NavigationDO, NavigationDOCriteria> getDao() {
        return mapper;
    }

    public List<NavigationDO> getUserNavigation(UserDO user) {

        NavigationDOCriteria nexample = new NavigationDOCriteria();

        //如果是超级管理员，则获取全部权限
        if ("1".equals(user.getId())) {
            nexample.setOrderByClause("compositor asc");
            return mapper.selectByExample(nexample);
        }

        //获取用户的角色类型
        UserDO temp = userDOMapper.selectByPrimaryKey(user.getId());
        String roleType = temp.getRoleType().toString();

        //根据角色类型获取对应的权限id的列表
        List<PermissionNavigationDO> perList = cpermissionNavigationDOMapper.selectList(roleType);

        if (perList.size() < 1) {
            return null;
        }

        List<Integer> ids = new ArrayList<Integer>();
        for (PermissionNavigationDO mo : perList) {
            ids.add(mo.getNavigationId());
        }

        UserPermissionDOCriteria userPermissionDOCriteria = new UserPermissionDOCriteria();
        userPermissionDOCriteria.createCriteria().andUserIdEqualTo(user.getId());
        List<UserPermissionDO> userPermissionDOS = userPermissionDOMapper.selectByExample(userPermissionDOCriteria);
        for (UserPermissionDO userPermissionDO : userPermissionDOS) {
            if (ids.contains(userPermissionDO.getNavigationId())) {
                ids.add(userPermissionDO.getNavigationId());
            }
        }

        //根据id列表查询对应权限列表
        NavigationDOCriteria.Criteria ncriteria = nexample.createCriteria();
        ncriteria.andIdIn(ids);
        nexample.setOrderByClause("compositor asc");
        List<NavigationDO> rList = mapper.selectByExample(nexample);
        return rList;
    }

    /*
     * (non-Javadoc)
     * @see cn.goldencis.tsa.system.service.INavigationService#getNavigation()
     */
    public String getNavigation() {
        NavigationDOCriteria nexample = new NavigationDOCriteria();
        nexample.setOrderByClause("compositor asc");
        List<NavigationDO> list = mapper.selectByExample(nexample);
        String nNodes = toTreeJson(list);
        return nNodes;
    }

    /**
     * 通过账户的角色类型，查询对应的页面集合
     *
     * @param roleType
     * @return
     */
    @Override
    public JSONArray getNavigationListByRoleType(Integer roleType) {
        //获取权限页面集合
        PermissionNavigationDOCriteria example = new PermissionNavigationDOCriteria();
        example.createCriteria().andPermissionIdEqualTo(roleType);
        List<PermissionNavigationDO> permissionNavigationList = permissionNavigationDOMapper.selectByExample(example);

        //转化为页面id集合
        List<Integer> navigationIdList = new ArrayList<>();
        for (PermissionNavigationDO permissionNavigation : permissionNavigationList) {
            navigationIdList.add(permissionNavigation.getNavigationId());
        }

        //获取全部页面集合
        NavigationDOCriteria navigationExample = new NavigationDOCriteria();
        List<NavigationDO> navigationList = mapper.selectByExample(navigationExample);

        //组装成需要返回的Json数组
        return toJson(navigationList, navigationIdList);

    }

    private JSONArray toJson(List<NavigationDO> navigations, List<Integer> navigationIdList) {
        JSONArray NavigationArray = new JSONArray();
        for (NavigationDO navigation : navigations) {
            JSONObject naviJson = new JSONObject();
            naviJson.put("id", navigation.getId());
            naviJson.put("pId", navigation.getParentId());
            naviJson.put("name", navigation.getTitle());
            naviJson.put("ParentNavigationId", navigation.getParentId());
            if (navigationIdList.contains(navigation.getId())) {
                naviJson.put("checked", true);
            }
            NavigationArray.add(naviJson);
        }
        return NavigationArray;
    }

    /**
     * 转化成ztree json
     *
     * @param navigations
     * @return
     */
    private String toTreeJson(List<NavigationDO> navigations) {
        JSONArray array = new JSONArray();
        for (NavigationDO navigation : navigations) {
            JSONObject obj = new JSONObject();
            obj.put("id", navigation.getId());
            obj.put("pId", navigation.getParentId());
            obj.put("name", navigation.getTitle());
            obj.put("iconSkin", "tNavigation");
            obj.put("ParentNavigationId", navigation.getParentId());
            obj.put("open", true);
            array.add(obj);
        }
        return array.toJSONString();
    }

}
