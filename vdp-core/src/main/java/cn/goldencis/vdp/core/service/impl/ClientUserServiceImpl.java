package cn.goldencis.vdp.core.service.impl;

import cn.goldencis.vdp.common.dao.BaseDao;
import cn.goldencis.vdp.common.service.impl.AbstractBaseServiceImpl;
import cn.goldencis.vdp.core.constants.ConstantsDto;
import cn.goldencis.vdp.core.dao.ClientUserDOMapper;
import cn.goldencis.vdp.core.entity.ClientUserDO;
import cn.goldencis.vdp.core.entity.ClientUserDOCriteria;
import cn.goldencis.vdp.core.entity.DepartmentDO;
import cn.goldencis.vdp.core.service.IClientUserService;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * Created by limingchao on 2017/12/22.
 */
@Service
public class ClientUserServiceImpl extends AbstractBaseServiceImpl<ClientUserDO , ClientUserDOCriteria> implements IClientUserService {

    @Autowired
    private ClientUserDOMapper mapper;

    @Override
    protected BaseDao<ClientUserDO, ClientUserDOCriteria> getDao() {
        return mapper;
    }

    /**
     * 按照主键查询用户
     * @param primaryKeyStr
     * @return
     */
    @Override
    public ClientUserDO getByPrimaryKey(String primaryKeyStr) {
        int primaryKey = Integer.parseInt(primaryKeyStr);
        return getDao().selectByPrimaryKey(primaryKey);
    }

    /**
     * 根据部门集合，查询对应的用户
     * @param departmentList
     * @param startNum
     * @param pageSize
     * @return
     */
    @Override
    public List<ClientUserDO> getClientUserListByDepartmentId(List<DepartmentDO> departmentList, Integer startNum, Integer pageSize) {

        //设置分页参数
        RowBounds rowBounds = new RowBounds(startNum,pageSize);

        //设置查询条件,将部门集合转化为部门id集合
        ClientUserDOCriteria example = new ClientUserDOCriteria();
        List<Integer> deptIdList = new ArrayList<>();
        for (DepartmentDO dept : departmentList) {
            deptIdList.add(dept.getId());
        }
        example.createCriteria().andDeptguidIn(deptIdList);

        //查询出条件部门下的用户集合
        List<ClientUserDO> clientUserList = mapper.selectByExampleWithRowbounds(example, rowBounds);

        return clientUserList;
    }

    @Override
    public long conutClientUserListByDepartmentId(List<DepartmentDO> departmentList) {
        ClientUserDOCriteria example = new ClientUserDOCriteria();
        List<Integer> deptIdList = new ArrayList<>();
        for (DepartmentDO dept : departmentList) {
            deptIdList.add(dept.getId());
        }
        example.createCriteria().andDeptguidIn(deptIdList);
        long count = mapper.countByExample(example);
        return count;
    }

    /**
     * 新建用户
     * @param clientUser
     * @return
     */
    @Transactional
    @Override
    public int addClientUser(ClientUserDO clientUser) {
        UUID uuid = UUID.randomUUID();

        clientUser.setGuid(uuid.toString());
        if (clientUser.getPolicyid() == null || clientUser.getPolicyid() == 0) {
            clientUser.setPolicyid(ConstantsDto.DEFAULT_POLICY_ID);
        }
        clientUser.setOnline("0");
        clientUser.setRegtime(new Date());

        return mapper.insertSelective(clientUser);
    }

    /**
     * 通过用户id删除用户
     * @param id
     */
    @Transactional
    @Override
    public void deleteClientUserById(Integer id) {
        mapper.deleteByPrimaryKey(id);
    }

    @Override
    public ClientUserDO getClientUserByName(String clientUserName) {
        ClientUserDOCriteria example = new ClientUserDOCriteria();
        example.createCriteria().andUsernameEqualTo(clientUserName);

        List<ClientUserDO> clientUserList = mapper.selectByExample(example);
        if (clientUserList != null && clientUserList.size() > 0) {
            return clientUserList.get(0);
        }
        return null;
    }

    /**
     * 检查用户名是否重复
     * @return 可用返回true
     */
    @Override
    public boolean checkClientUserNameDuplicate(ClientUserDO clientUser) {

        //通过用户名获取数据库中用户记录
        ClientUserDO preClientUser = this.getClientUserByName(clientUser.getUsername());

        //判断数据库是否有该记录，不存在即可用，返回true，如果有继续判断
        if (preClientUser != null) {
            //比较两个对象的id，若一致，是同一个对象没有改变名称的情况，返回可用true。
            if (preClientUser.getId() != clientUser.getId()) {
                //若果不同，说明为两个用户，名称重复，不可用，返回false
                return false;
            }
        }
        return true;
    }

    /**
     * 根据用户id，更新用户信息
     * @param clientUser
     */
    @Transactional
    @Override
    public void updateClientUser(ClientUserDO clientUser) {
        //判断USBKey是否更新
        ClientUserDO preClientUser = this.getByPrimaryKey(clientUser.getPrimaryKey());
        /*if (preClientUser.get) {
            //如果跟原先不一致，解绑之前的key，重新绑定新key

        }*/

        mapper.updateByPrimaryKeySelective(clientUser);
    }

    /**
     * 批量更新策略。批量更新id包含集合中的用户，将策略更新为新的策略id
     * @param idList 需要更新策略的用户id集合
     * @param policyid 需要更新的策略id
     */
    @Override
    @Transactional
    public void batchUpdateClientUsersPolicy(List<Integer> idList, Integer policyid) {
        ClientUserDOCriteria example = new ClientUserDOCriteria();
        example.createCriteria().andIdIn(idList);
        ClientUserDO clientUser = new ClientUserDO();
        clientUser.setPolicyid(policyid);
        mapper.updateByExampleSelective(clientUser, example);
    }
}
