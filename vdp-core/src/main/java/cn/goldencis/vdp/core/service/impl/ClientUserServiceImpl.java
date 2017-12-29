package cn.goldencis.vdp.core.service.impl;

import cn.goldencis.vdp.common.dao.BaseDao;
import cn.goldencis.vdp.common.service.impl.AbstractBaseServiceImpl;
import cn.goldencis.vdp.core.dao.ClientUserDOMapper;
import cn.goldencis.vdp.core.entity.ClientUserDO;
import cn.goldencis.vdp.core.entity.ClientUserDOCriteria;
import cn.goldencis.vdp.core.service.IClientUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by limingchao on 2017/12/22.
 */
@Service
public class ClientUserServiceImpl extends AbstractBaseServiceImpl<ClientUserDO , ClientUserDOCriteria> implements IClientUserService {

    @Autowired
    private ClientUserDOMapper clientUserMapper;

    @Override
    protected BaseDao<ClientUserDO, ClientUserDOCriteria> getDao() {
        return clientUserMapper;
    }

    @Override
    public ClientUserDO getByPrimaryKey(String primaryKeyStr) {
        int primaryKey = Integer.parseInt(primaryKeyStr);
        return getDao().selectByPrimaryKey(primaryKey);
    }

}
