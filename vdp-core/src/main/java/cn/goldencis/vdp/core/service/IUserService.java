package cn.goldencis.vdp.core.service;

import java.util.List;
import java.util.Map;

import cn.goldencis.vdp.common.service.BaseService;
import cn.goldencis.vdp.core.entity.DepartmentDO;
import cn.goldencis.vdp.core.entity.UserDO;
import cn.goldencis.vdp.core.entity.UserDOCriteria;

/**
 * 管理员service
 *
 * @author Administrator
 */
public interface IUserService extends BaseService<UserDO, UserDOCriteria> {

    List<UserDO> getUserList(UserDO user);

    List<UserDO> getAllUser();

    UserDO getLoginUser(String username);

    UserDO getLoginUserNoCache(String username);

    Long countUserList(UserDO user);

    /**
     * 获取顶级部门
     *
     * @return
     */
    DepartmentDO getSuperDepartment();

    /**
     * 根据登录用户获取权限部门
     *
     * @param name
     * @return
     */
    List<DepartmentDO> getLoginDepartMent(String name);

    List<DepartmentDO> getUserRoleDepartmentByUserOptimised(String id);

    boolean addOrUpdateUser(UserDO user, String departmentListStr, String navigationListStr);

    /**
     * 删除用户，真实删除
     * @param user
     */
    void deleteUser(UserDO user);

    void deleteUserByDepartmentId(String departmentId, String userId);

    Long selectUserCountByPermission(String permissionId);

    /**
     * 通过账户名称获取账户对象
     * @param userName
     * @return
     */
    UserDO getUserByUserName(String userName);

    void updateUser(UserDO user);

    /**
     * 查询用户是否不想显示提示
     *
     * @param userId
     * @return
     */
    int queryRefusePromptUser(String userId);

    /**
     * 用户不想显示提示 保存
     *
     * @param userId
     * @return
     */
    int insertRefusePromptUser(String userId);

    int updateErrorLoginCount(String userId, boolean success) throws Exception;

    Map<String, Object> queryErrorLoginInfo(String userId);

	UserDO getLoginUserNoCacheByUserName(String userName);

	List<UserDO> getUserListByLoginUserRoleType(Integer roleType);

    /**
     * 根据登录用户的角色类型，获取相应类型的账户分页列表。
     * @param user 当前登录用户
     * @param start
     * @param length
     * @return
     */
    List<UserDO> getUserListByLoginUserRoleTypeInPages(UserDO user, int start, int length);

    /**
     * 根据登录用户的角色类型，获取相应类型的账户列表的总数
     * @param user 当前登录用户
     * @return
     */
    int countUserListByLoginUserRoleTypeInPages(UserDO user);

    /**
     * 检查账户名是否重复
     * @param user
     * @return 可用返回true
     */
    boolean checkUserNameDuplicate(UserDO user);

    /**
     * 根据账户id，查询账户对象
     * @param userId
     * @return
     */
    UserDO getUserByUserId(Integer userId);

    /**
     * 修改账户个人资料
     * @param user
     */
    void updateUserInfo(UserDO user);
}
