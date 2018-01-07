package cn.goldencis.vdp.core.dao;

import cn.goldencis.vdp.common.annotation.Mybatis;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by limingchao on 2018/1/7.
 */
@Mybatis
public interface CUserNavigationDOMapper {

    void batchInsertByOneUserAndNavigationList(@Param("userId") String userId, @Param("navigationIdList") List<Integer> navigationIdList);

    /**
     * 删除账户页面权限关联表中关联该账户的记录
     * @param userId
     */
    void batchDeleteUserNavigationByUserId(String userId);
}
