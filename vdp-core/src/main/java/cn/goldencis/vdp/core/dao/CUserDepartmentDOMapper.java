package cn.goldencis.vdp.core.dao;

import java.util.List;

import cn.goldencis.vdp.core.entity.UserDO;
import org.apache.ibatis.annotations.Param;

import cn.goldencis.vdp.common.annotation.Mybatis;
import cn.goldencis.vdp.core.entity.UserDepartmentDO;

@Mybatis
public interface CUserDepartmentDOMapper {

    void batchInsertByOneUserAndDepartmentList(@Param("userId") String userId, @Param("departmentIdList") List<Integer> departmentIdList);

    void deleteBatch(@Param("list") List<String> list, @Param("departmentId") String departmentId);

    List<UserDO> selectUserListByDepartment(UserDepartmentDO udp);

    /**
     * 删除账户部门关联表中关联该账户的记录
     * @param userId
     */
    void batchDeleteUserDepartmentByUserId(String userId);
}
