package cn.goldencis.vdp.core.service;

import java.util.List;

import cn.goldencis.vdp.common.service.BaseService;
import cn.goldencis.vdp.core.entity.DepartmentDO;
import cn.goldencis.vdp.core.entity.DepartmentDOCriteria;

/**
 * 部门管理service
 * @author Administrator
 *
 */
public interface IDepartmentService extends BaseService<DepartmentDO, DepartmentDOCriteria> {

    /**
     * 根据查询条件获取列表，分页查询
     * @param startNum
     * @param pageSize
     * @param pId
     * @param treePath
     * @param ordercase
     * @return
     */
    List<DepartmentDO> getDeptarMentListByParent(Integer startNum, Integer pageSize, Integer pId, String treePath, String ordercase);

    /**
     * 根据查询条件获取全部列表
     * @param pId
     * @return
     */
    List<DepartmentDO> getDeptarMentListByParent(Integer pId);
    /**
     * 根据条件查询总数
     * @param pId
     * @param treePath
     * @return
     */
    long getDeptarMentCountByParent(Integer pId, String treePath);

    /**
     * 管理员获取无权限控制
     * @return
     */
    String getManagerNodes();

    /**
     * 根据登录用户权限获取部门树json
     * @return
     */
    String getNodesByLogin();

    /**
     * 通过管理员Id获取已选中部门
     * @param uid
     * @return
     */
    String getChecked(Integer uid);

    /**
     * 修改部门
     * @param bean
     * @return
     */
    boolean updatedept(DepartmentDO bean);

    /**
     * 获取所有权限的列表
     * @param id
     * @return
     */
    List<String> getAllRoleDept(Integer id);

    /**
     * 删除部门
     * @param id
     * @return
     */
    boolean deleteById(Integer id);

    DepartmentDO getDepartmentById(Integer id);

    String getFunctionNodesByLogin();

    /**
     * 根据部门名字查找部门
     * @param name
     * @return
     */
    List<DepartmentDO> selectDepartmentByName(String name);

    /**
     * 添加部门
     *
     * @param bean
     * @return
     */
    boolean addDepartment(DepartmentDO bean);

    /**
     * 为列表中的部门添加父类部门名称
     * @param parentDept 总父类
     * @param departmentList 需要添加父类部门名称的列表
     */
    void setParentDepartmentNames(DepartmentDO parentDept, List<DepartmentDO> departmentList);
}
