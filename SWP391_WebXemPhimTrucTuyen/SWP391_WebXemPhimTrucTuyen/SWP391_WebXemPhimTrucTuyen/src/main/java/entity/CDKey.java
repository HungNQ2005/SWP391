/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;


/**
 *
 * @author Nguyen Quoc Hung - CE190870
 */

public class CDKey {
    private int keyID;
    private String keyCode;
    private String keyStatus;
    private String keyGeneratedBy;
    private Timestamp keyGeneratedTime;

    public CDKey() {}

    public CDKey(int keyID, String keyCode, String keyStatus, String keyGeneratedBy, Timestamp keyGeneratedTime) {
        this.keyID = keyID;
        this.keyCode = keyCode;
        this.keyStatus = keyStatus;
        this.keyGeneratedBy = keyGeneratedBy;
        this.keyGeneratedTime = keyGeneratedTime;
    }

    public int getKeyID() {
        return keyID;
    }

    public void setKeyID(int keyID) {
        this.keyID = keyID;
    }

    public String getKeyCode() {
        return keyCode;
    }

    public void setKeyCode(String keyCode) {
        this.keyCode = keyCode;
    }

    public String getKeyStatus() {
        return keyStatus;
    }

    public void setKeyStatus(String keyStatus) {
        this.keyStatus = keyStatus;
    }

    public String getKeyGeneratedBy() {
        return keyGeneratedBy;
    }

    public void setKeyGeneratedBy(String keyGeneratedBy) {
        this.keyGeneratedBy = keyGeneratedBy;
    }

    public Timestamp getKeyGeneratedTime() {
        return keyGeneratedTime;
    }

    public void setKeyGeneratedTime(Timestamp keyGeneratedTime) {
        this.keyGeneratedTime = keyGeneratedTime;
    }
}