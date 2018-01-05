package cn.goldencis.vdp.core.dao;

import cn.goldencis.vdp.common.annotation.Mybatis;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by limingchao on 2018/1/5.
 */
@Mybatis
public interface CClientUserDOMapper {

    /**
     * 传入需要修改的部门id，将该id部门下的用户，置为未分组
     * @param departmentId
     */
    void setClientUsersUngroup(@Param(value = "departmentId") Integer departmentId);

}
