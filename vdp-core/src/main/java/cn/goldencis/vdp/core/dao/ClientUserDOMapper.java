package cn.goldencis.vdp.core.dao;

import cn.goldencis.vdp.common.dao.BaseDao;
import cn.goldencis.vdp.core.entity.ClientUserDO;
import cn.goldencis.vdp.core.entity.ClientUserDOCriteria;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

public interface ClientUserDOMapper extends BaseDao {
    long countByExample(ClientUserDOCriteria example);

    int deleteByExample(ClientUserDOCriteria example);

    int deleteByPrimaryKey(Integer id);

    int insert(ClientUserDO record);

    int insertSelective(ClientUserDO record);

    List<ClientUserDO> selectByExampleWithRowbounds(ClientUserDOCriteria example, RowBounds rowBounds);

    List<ClientUserDO> selectByExample(ClientUserDOCriteria example);

    ClientUserDO selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") ClientUserDO record, @Param("example") ClientUserDOCriteria example);

    int updateByExample(@Param("record") ClientUserDO record, @Param("example") ClientUserDOCriteria example);

    int updateByPrimaryKeySelective(ClientUserDO record);

    int updateByPrimaryKey(ClientUserDO record);
}