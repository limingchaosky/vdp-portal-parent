package cn.goldencis.vdp.core.service.impl;

import java.util.*;

import cn.goldencis.vdp.core.constants.ConstantsDto;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import cn.goldencis.vdp.common.dao.BaseDao;
import cn.goldencis.vdp.common.service.impl.AbstractBaseServiceImpl;
import cn.goldencis.vdp.core.dao.CustomizedMapper;
import cn.goldencis.vdp.core.dao.DepartmentDOMapper;
import cn.goldencis.vdp.core.dao.UserDepartmentDOMapper;
import cn.goldencis.vdp.core.entity.DepartmentDO;
import cn.goldencis.vdp.core.entity.DepartmentDOCriteria;
import cn.goldencis.vdp.core.entity.UserDepartmentDO;
import cn.goldencis.vdp.core.entity.UserDepartmentDOCriteria;
import cn.goldencis.vdp.core.service.IDepartmentService;
import cn.goldencis.vdp.core.utils.GetLoginUser;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/**
 * 部门管理service实现类
 * @author Administrator
 *
 */
@Component("departmentService")
public class DepartmentServiceImpl extends AbstractBaseServiceImpl<DepartmentDO, DepartmentDOCriteria> implements
        IDepartmentService {

    @Autowired
    private DepartmentDOMapper mapper;

    @Autowired
    private CustomizedMapper cmapper;

    @Autowired
    private UserDepartmentDOMapper udmapper;

    @SuppressWarnings("unchecked")
    @Override
    protected BaseDao<DepartmentDO, DepartmentDOCriteria> getDao() {
        return mapper;
    }

    /**
     * 管理员无权限限制，获取全部部门树json
     * @return
     */
    public String getManagerNodes() {
        String zNodes = toTreeJson(cmapper.getDeptarMentList(null, null, null, null, null), false);
        return zNodes;
    }

    /*
     * 根据登录用户权限获取部门树json
     * @param ischeck 是否有未分组
     * @return
     */
    public String getNodesByLogin() {

        //String zNodes = "";
        List<DepartmentDO> departmentList = GetLoginUser.getDepartmentListWithLoginUser();

        if (departmentList != null && departmentList.size() > 0 && "1".equals(departmentList.get(0).getId())) {
            //如果有顶级部门权限，则参数全部为null，返回所有部门列表
            return toTreeJson(cmapper.getDeptarMentList(null, null, null, null, null), false);
        } else {
            //如果没有顶级部门权限进行查询
            List<Integer> ids = new ArrayList<>();
            List<String> treePaths = new ArrayList<>();
            for (DepartmentDO dept : departmentList) {
                ids.add(dept.getId());
                treePaths.add(dept.getTreePath() + dept.getId() + ",%");
            }
            return toTreeJson(cmapper.getUserRoleDepartmentByUser(ids, treePaths, true), true);
        }

    }

    /**
     * 修改部门
     * @param bean
     * @return
     */
    @Transactional
    public boolean updatedept(DepartmentDO bean) {

        if (ConstantsDto.SUPER_DEPARTMENT_ID.equals(bean.getId().toString())) {
            mapper.updateByPrimaryKeySelective(bean);
        } else {
            DepartmentDO pdept = mapper.selectByPrimaryKey(String.valueOf(bean.getParentId()));

            //获取修改之前，部门的部门树+id，用来查询子部门。,1,44,45,
            String oldtreepath = bean.getTreePath() + bean.getId() + ",";
            //通过父类部门，获取修改后的部门树.,1,
            String newtreepath = pdept.getTreePath() + pdept.getId() + ",";

            //获取修改部门之前，该部门下的子类部门列表
            DepartmentDOCriteria example = new DepartmentDOCriteria();
            example.createCriteria().andTreePathLike(oldtreepath + "%");
            List<DepartmentDO> clist = mapper.selectByExample(example);

            //保存修改的部门id列表
            List<Integer> dids = new ArrayList<>();
            dids.add(bean.getId());

            //跟新子部门的部门树
            for (DepartmentDO cdept : clist) {
                //添加到修改部门id列表
                dids.add(cdept.getId());
                //替换子类部门的部门树
                String treePath = cdept.getTreePath();
                treePath = treePath.replace(bean.getTreePath(), newtreepath);
                cdept.setTreePath(treePath);
                //跟新子类部门
                mapper.updateByPrimaryKeySelective(cdept);
            }

            //更新本次修改部门的部门树
            bean.setTreePath(newtreepath);
            //bean.setStatus(1);
            //更新部门
            mapper.updateByPrimaryKeySelective(bean);

            //获取部门用户关联列表
            UserDepartmentDOCriteria udexample = new UserDepartmentDOCriteria();
            udexample.createCriteria().andDepartmentIdEqualTo(bean.getId());
            List<UserDepartmentDO> hlist = udmapper.selectByExample(udexample);

            //获取关联用户的id集合
            List<String> userids = new ArrayList<>();
            if (hlist != null) {
                hlist.forEach(tmp -> userids.add(tmp.getUserId()));
            }

            //获取修改部门后，有父类部门权限的用户中，没有当前部门权限的，用户部门关联表。需要为他们添加本次修改部门的权限
            udexample.clear();
            udexample.createCriteria().andDepartmentIdEqualTo(bean.getParentId()).andUserIdNotIn(userids);
            List<UserDepartmentDO> nlist = udmapper.selectByExample(udexample);
            //添加用户部门权限
            addRole(nlist, dids);
        }
        return true;
    }

    /**
     * 未用
     * @param id
     * @return
     */
    @Override
    public List<String> getAllRoleDept(Integer id) {
        List<DepartmentDO> roleDept = new ArrayList<>();
        List<String> rlist = new ArrayList<>();
        //避免权限为空时跳过条件而查询出所有，前端已限制不可输入未分组
        rlist.add("0");
        //未分组查询
        if (id != null && id.intValue() == 0) {
            return rlist;
            //查询单个(如果是1则查询全部)
        } else if (id != null && id.intValue() != 1) {
            roleDept.add(mapper.selectByPrimaryKey(id.toString()));
            //查询全部
        } else {
            roleDept = GetLoginUser.getDepartmentListWithLoginUser();
        }

        List<Integer> ids = new ArrayList<>();
        List<String> treePaths = new ArrayList<>();
        for (DepartmentDO dept : roleDept) {
            ids.add(dept.getId());
            treePaths.add(dept.getTreePath() + dept.getId() + ",%");
        }
        rlist.addAll(getIdlist(cmapper.getUserRoleDepartmentByUser(ids, treePaths, false)));
        return rlist;
    }

    /**
     * 获取部门名称
     * @param roledept
     * @return
     */
    public List<String> getIdlist(List<DepartmentDO> roledept) {
        List<String> rlist = new ArrayList<>();
        if (roledept != null) {
            for (DepartmentDO dept : roledept) {
                rlist.add(dept.getId().toString());
            }
        }
        return rlist;
    }

    /**
     * 通过父类id和父类treePath查询子类集合，返回列表中包含父类本身。分页查询。
     * @param startNum
     * @param pageSize
     * @param pId 父类id
     * @param treePath 父类treePath
     * @param ordercase 查询条件，暂未实现
     * @return
     */
    @Override
    public List<DepartmentDO> getDeptarMentListByParent(Integer startNum, Integer pageSize, Integer pId, String treePath, String ordercase) {

        RowBounds rowBounds = new RowBounds(startNum, pageSize);

        //通过父类id和父类treePath、和父类本身 查询子类集合
        DepartmentDOCriteria departmentDOCriteria = new DepartmentDOCriteria();
        departmentDOCriteria.createCriteria().andParentIdEqualTo(pId);
        departmentDOCriteria.or().andTreePathLike(treePath);
        departmentDOCriteria.or().andIdEqualTo(pId);

        List<DepartmentDO> departmentList = mapper.selectByExampleWithRowbounds(departmentDOCriteria, rowBounds);
        return departmentList;
    }

    /**
     *
     * @param pId
     * @return
     */
    @Override
    public List<DepartmentDO> getDeptarMentListByParent(Integer pId) {
        DepartmentDO parentDept = mapper.selectByPrimaryKey(String.valueOf(pId));
        DepartmentDOCriteria departmentDOCriteria = new DepartmentDOCriteria();
        departmentDOCriteria.createCriteria().andParentIdEqualTo(pId);
        departmentDOCriteria.or().andTreePathLike(parentDept.getTreePath() + parentDept.getId() + "%");
        List<DepartmentDO> departmentList = mapper.selectByExample(departmentDOCriteria);
        departmentList.add(parentDept);
        return departmentList;
    }

    /**
     * 通过父类id和父类treePath、和父类本身 查询子类集合的总数量
     * @param pId
     * @param treePath
     * @return
     */
    @Override
    public long getDeptarMentCountByParent(Integer pId, String treePath) {
        //通过父类id和父类treePath、和父类本身 查询子类集合的总数量
        DepartmentDOCriteria departmentDOCriteria = new DepartmentDOCriteria();
        departmentDOCriteria.createCriteria().andParentIdEqualTo(pId);
        departmentDOCriteria.or().andTreePathLike(treePath);
        departmentDOCriteria.or().andIdEqualTo(pId);

        return mapper.countByExample(departmentDOCriteria);
    }

    @Override
    public String getChecked(Integer uid) {
        // TODO Auto-generated method stub
        return null;
    }

    /*
     * (non-Javadoc)
     * @see cn.goldencis.tsa.system.service.IDepartmentService#deleteById(java.lang.Integer)
     */
    @Transactional
    public boolean deleteById(Integer id) {
        //根据部门id，查询该部门UserDepartmentDO的关联
        UserDepartmentDOCriteria udexample = new UserDepartmentDOCriteria();
        udexample.createCriteria().andDepartmentIdEqualTo(id);
        List<UserDepartmentDO> userList = udmapper.selectByExample(udexample);

        //遍历与当前部门关联的用户列表
        for (UserDepartmentDO temp : userList) {
            //查询当前用户关联的部门列表
            UserDepartmentDOCriteria tmpCriteria = new UserDepartmentDOCriteria();
            tmpCriteria.createCriteria().andUserIdEqualTo(temp.getUserId()).andDepartmentIdNotEqualTo(id);
            //如果当前用户没有其他关联部门，则创建一条与未分组关联的记录，插入数据库，用户分组调整为未分组。
            if (udmapper.selectByExample(tmpCriteria).size() == 0) {
                UserDepartmentDO record = new UserDepartmentDO();
                record.setDepartmentId(new Integer(ConstantsDto.DEPARTMENT_UNKOWN_GROUP));
                record.setUserId(temp.getUserId());
                udmapper.insert(record);
            }
        }
        udmapper.deleteByExample(udexample);
        mapper.deleteByPrimaryKey(id.toString());
        return true;
    }

    /**
     * 转化成ztree json
     * @param departments
     * @param isedit
     * @return
     */
    private String toTreeJson(List<DepartmentDO> departments, boolean isedit) {
        JSONArray array = new JSONArray();
        JSONObject unknownGroup = new JSONObject();
        boolean hasUnknown = false;
        for (DepartmentDO department : departments) {
            JSONObject obj = new JSONObject();
            if (isedit && 1 == department.getId()) {
                obj.put("checkdisable", true);
            }
            if (2 == department.getId()) {
                unknownGroup.put("remark", department.getDepartmentRemark());
                unknownGroup.put("id", department.getId());
                unknownGroup.put("pId", department.getParentId());
                unknownGroup.put("name", department.getName());
                unknownGroup.put("iconSkin", "tDepartment");
                unknownGroup.put("ParentDepartmentId", department.getParentId());
                unknownGroup.put("treePath", department.getTreePath());
                unknownGroup.put("open", true);
                unknownGroup.put("status", department.getStatus());
                hasUnknown = true;
            } else {
                obj.put("remark", department.getDepartmentRemark());
                obj.put("id", department.getId());
                obj.put("pId", department.getParentId());
                obj.put("name", department.getName());
                obj.put("iconSkin", "tDepartment");
                obj.put("ParentDepartmentId", department.getParentId());
                obj.put("treePath",department.getTreePath());
                obj.put("open", true);
                obj.put("status", department.getStatus());
                array.add(obj);
            }
        }
        if (hasUnknown) {
            array.add(unknownGroup);
        }
        return array.toJSONString();
    }

    @Override
    public DepartmentDO getDepartmentById(Integer id) {
        return mapper.selectByPrimaryKey(id.toString());
    }

    @Override
    public String getFunctionNodesByLogin() {
        List<DepartmentDO> roleDept = GetLoginUser.getDepartmentListWithLoginUser();
        List<DepartmentDO> ids = new ArrayList<>();
        DepartmentDO department = null;
        if (roleDept.size() > 0) {
            for (DepartmentDO dept : roleDept) {
                department = new DepartmentDO();
                department.setId(dept.getId());
                dept.setTreePath(dept.getTreePath() == null ? "" : dept.getTreePath());
                department.setTreePath("%" + dept.getTreePath() + dept.getId() + ",%");
                ids.add(department);
            }
            return toTreeJson(cmapper.getFunctionNodesByLogin(ids), true);
        } else {
            List<DepartmentDO> departments = new ArrayList<DepartmentDO>();
            departments.add(getDepartmentById(ConstantsDto.SUPER_DEPARTMENT_ID));
            return toTreeJson(departments, true);
        }
    }

    @Override
    public List<DepartmentDO> selectDepartmentByName(String name) {
        DepartmentDOCriteria udexample = new DepartmentDOCriteria();
        udexample.createCriteria().andNameEqualTo(name);
        return mapper.selectByExample(udexample);
    }

    @Override
    @Transactional
    public boolean addDepartment(DepartmentDO bean) {

        //插入当前传入的部门，注意：要在mybatis的配置文件中使用keyProperty将主键id传回。
        mapper.insertSelective(bean);

        //查询与父类部门相关联的用户集合
        UserDepartmentDOCriteria example = new UserDepartmentDOCriteria();
        example.createCriteria().andDepartmentIdEqualTo(bean.getParentId());
        List<UserDepartmentDO> list = udmapper.selectByExample(example);

        //传入插入sql时回传的部门id
        List<Integer> dids = new ArrayList<>();
        dids.add(bean.getId());

        //将新增部门和父类部门下的关联用户进行关联。
        cmapper.addUserDeparts(addRole(list, dids));
        return true;
    }

    @Override
    public void setParentDepartmentNames(DepartmentDO parentDept, List<DepartmentDO> departmentList) {

        //设置查询标记
        boolean selectFlag = false;

        //将父类部门和列表转化为Map
        Map<Integer, DepartmentDO> parentDepartmentMap = new HashMap<>();
        parentDepartmentMap.put(parentDept.getId(), parentDept);
        for (DepartmentDO department : departmentList) {
            parentDepartmentMap.put(department.getId(), department);
        }

        //遍历列表，从Map中获取父类部门并赋值父类名称。
        List<Integer> parentDepartmentIds = new ArrayList<>();
        for (DepartmentDO department : departmentList) {
            if (parentDepartmentMap.containsKey(department.getParentId())) {
                department.setParentName(parentDepartmentMap.get(department.getParentId()).getName());
            } else {
                //Map中没有父类，添加到List中等待查询
                if (!parentDepartmentIds.contains(department.getParentId())) {
                    parentDepartmentIds.add(department.getParentId());
                }
                selectFlag = true;
            }
        }

        //查询父类的部门，给剩余部门的父类名称赋值
        if (selectFlag) {
            DepartmentDOCriteria example = new DepartmentDOCriteria();
            example.createCriteria().andIdIn(parentDepartmentIds);
            List<DepartmentDO> selectDepartments = mapper.selectByExample(example);
            for (DepartmentDO department : selectDepartments) {
                parentDepartmentMap.put(department.getId(),department);
            }
            for (DepartmentDO department : departmentList) {
                if ((department.getParentName() == null || "".equals(department.getParentName())) && department.getId() != 1) {
                    department.setParentName(parentDepartmentMap.get(department.getParentId()).getName());
                }
            }
        }
    }

    /**
     * 将用户id集合跟部门id，交叉组合，返回UserDepartmentDO关联表对象集合
     * @param list
     * @param dids
     * @return List<UserDepartmentDO>UserDepartmentDO关联表对象集合
     */
    public List<UserDepartmentDO> addRole(List<UserDepartmentDO> list, List<Integer> dids) {
        List<UserDepartmentDO> addlist = new ArrayList<>();
        if (list != null) {
            list.forEach(tmp -> {
                dids.forEach(dtmp -> {
                    UserDepartmentDO uddo = new UserDepartmentDO();
                    uddo.setDepartmentId(dtmp.intValue());
                    uddo.setUserId(tmp.getUserId());
                    addlist.add(uddo);
                });

            });
        }
        return addlist;
    }
}