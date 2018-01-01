package cn.goldencis.vdp.core.service;

import cn.goldencis.vdp.common.service.BaseService;
import cn.goldencis.vdp.core.entity.ClientUserDO;
import cn.goldencis.vdp.core.entity.ClientUserDOCriteria;

import java.util.List;

/**
 * Created by limingchao on 2017/12/22.
 */
public interface IClientUserService extends BaseService<ClientUserDO, ClientUserDOCriteria> {

    List<ClientUserDO> getClientUserListByDepartmentId();

}
