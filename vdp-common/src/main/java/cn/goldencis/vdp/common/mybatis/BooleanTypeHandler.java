package cn.goldencis.vdp.common.mybatis;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * 自定义Boolean类型转换器.<br/>
 * java中的boolean和jdbc中的int之间转换;true-1;false-0.
 * <br/>
 * @author liuzhh.
 * @date Sep 21, 2016
 * @version 1.0.0-SNAPSHOT
 */
@SuppressWarnings("rawtypes")
public class BooleanTypeHandler implements TypeHandler {

    /* (non-Javadoc)
     * @see org.apache.ibatis.type.TypeHandler#getResult(java.sql.ResultSet, java.lang.String)
     */
    public Object getResult(ResultSet arg0, int arg1) throws SQLException {
        int num = arg0.getInt(arg1);
        Boolean rt = Boolean.FALSE;
        if (num == 1) {
            rt = Boolean.TRUE;
        }
        return rt;
    }

    /* (non-Javadoc)
     * @see org.apache.ibatis.type.TypeHandler#getResult(java.sql.CallableStatement, int)
     */
    public Object getResult(CallableStatement arg0, int arg1) throws SQLException {
        Boolean b = arg0.getBoolean(arg1);
        return b ? 1 : 0;
    }

    /* (non-Javadoc)
     * @see org.apache.ibatis.type.TypeHandler#setParameter(java.sql.PreparedStatement, int, java.lang.Object, org.apache.ibatis.type.JdbcType)
     */
    public void setParameter(PreparedStatement arg0, int arg1, Object arg2, JdbcType arg3) throws SQLException {
        Boolean b = (Boolean) arg2;
        int value = (Boolean) b ? 1 : 0;
        arg0.setInt(arg1, value);
    }

    public Object getResult(ResultSet arg0, String arg1) throws SQLException {
        int num = arg0.getInt(arg1);
        Boolean rt = Boolean.FALSE;
        if (num == 1) {
            rt = Boolean.TRUE;
        }
        return rt;
    }

}