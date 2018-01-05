package cn.goldencis.vdp.core.service;

import cn.goldencis.vdp.common.service.BaseService;
import cn.goldencis.vdp.core.entity.ClientUserDO;
import cn.goldencis.vdp.core.entity.ClientUserDOCriteria;
import cn.goldencis.vdp.core.entity.DepartmentDO;

import java.util.List;

/**
 * Created by limingchao on 2017/12/22.
 */
public interface IClientUserService extends BaseService<ClientUserDO, ClientUserDOCriteria> {

    /**
     * 根据用户id查找用户
     * @param id
     * @return
     */
    ClientUserDO getClientUserById(Integer id);

    /**
     * 根据部门集合，查询对应的用户列表
     * @param departmentList
     * @param startNum
     * @param pageSize
     * @return
     */
    List<ClientUserDO> getClientUserListByDepartmentId(List<DepartmentDO> departmentList, Integer startNum, Integer pageSize);

    /**
     * 根据部门集合，查询对应的用户数量
     * @param departmentList
     * @return
     */
    long conutClientUserListByDepartmentId(List<DepartmentDO> departmentList);

    /**
     * 新建用户
     * @param clientUser
     * @param usbkeyid
     * @return
     */
    int addClientUser(ClientUserDO clientUser, Integer usbkeyid);

    /**
     * 通过用户id删除用户
     * @param id
     */
    void deleteClientUserById(Integer id);

    /**
     * 通过用户名查找用户
     * @param id
     * @return
     */
    ClientUserDO getClientUserByName(String clientUserName);

    /**
     * 检查用户名是否重复
     * @return
     */
    boolean checkClientUserNameDuplicate(ClientUserDO clientUser);

    /**
     * 根据用户id，更新用户信息
     * @param clientUser
     */
    void updateClientUser(ClientUserDO clientUser);

    /**
     * 批量更新策略。批量更新id包含集合中的用户，将策略更新为新的策略id
     * @param idList 需要更新策略的用户id集合
     * @param policyid 需要更新的策略id
     */
    void batchUpdateClientUsersPolicy(List<Integer> idList, Integer policyid);
}
