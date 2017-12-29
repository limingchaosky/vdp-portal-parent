package cn.goldencis.vdp.core.entity;

import cn.goldencis.vdp.common.entity.BaseEntity;

import java.io.Serializable;

public class UserPermissionDO extends BaseEntity implements Serializable {
    private String userId;

    private Integer navigationId;

    private static final long serialVersionUID = 1L;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public Integer getNavigationId() {
        return navigationId;
    }

    public void setNavigationId(Integer navigationId) {
        this.navigationId = navigationId;
    }

    @Override
    public String getPrimaryKey() {
        return getUserId() + "" + getNavigationId();
    }
}