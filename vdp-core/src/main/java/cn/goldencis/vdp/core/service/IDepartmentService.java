package cn.goldencis.vdp.core.service;

import java.util.List;

import cn.goldencis.vdp.common.service.BaseService;
import cn.goldencis.vdp.core.entity.DepartmentDO;
import cn.goldencis.vdp.core.entity.DepartmentDOCriteria;
import com.alibaba.fastjson.JSONArray;

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
     * 管理员无权限限制，获取全部部门树json
     * @return
     */
    String getManagerNodes();

    /**
     * 根据登录用户权限获取部门树json
     * @return
     */
    String getNodesByLogin();

    /**
     * 修改部门
     * @param bean
     * @return
     */
    boolean updatedept(DepartmentDO bean);

    /**
     * 删除部门
     * @param id
     * @return
     */
    boolean deleteById(Integer id);

    /**
     * 通过部门id获取对应部门对象
     * @param id
     * @return
     */
    DepartmentDO getDepartmentById(Integer id);

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

    /**
     * 获取全部部门树，如果账户id，查询账户对应的部门权限，加上check:true
     * @param userId
     * @return
     */
    JSONArray getDepartmentTreeByUserId(Integer userId);
}
