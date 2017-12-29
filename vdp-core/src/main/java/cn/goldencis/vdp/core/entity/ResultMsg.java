package cn.goldencis.vdp.core.entity;

import cn.goldencis.vdp.core.constants.ConstantsDto;

/**
 * Created by mengll on 2017/10/24 0024.
 */
public class ResultMsg {
    private Integer resultCode = ConstantsDto.RESULT_CODE_FALSE;
    private String resultMsg;
    private Object data;
    private Integer recordsTotal;
    private Integer exportlength;
    private Integer exportstart;
    private Integer recordsFiltered;

    public Integer getRecordsFiltered() {
        return recordsFiltered;
    }

    public void setRecordsFiltered(Integer recordsFiltered) {
        this.recordsFiltered = recordsFiltered;
    }

    public Integer getRecordsTotal() {
        return recordsTotal;
    }

    public void setRecordsTotal(Integer recordsTotal) {
        this.recordsTotal = recordsTotal;
        this.recordsFiltered = this.recordsTotal;
    }

    public Integer getExportlength() {
        return exportlength;
    }

    public void setExportlength(Integer exportlength) {
        this.exportlength = exportlength;
    }

    public Integer getExportstart() {
        return exportstart;
    }

    public void setExportstart(Integer exportstart) {
        this.exportstart = exportstart;
    }

    public Integer getResultCode() {
        return resultCode;
    }

    public void setResultCode(Integer resultCode) {
        this.resultCode = resultCode;
    }

    public String getResultMsg() {
        return resultMsg;
    }

    public void setResultMsg(String resultMsg) {
        this.resultMsg = resultMsg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object resultObj) {
        this.data = resultObj;
    }
}
