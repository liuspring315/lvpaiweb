package com.starlighting.lvpaiweb.service.manager;

import com.starlighting.lvpaiweb.bean.UserGeneralInfo;
import com.starlighting.lvpaiweb.bean.UserTypeEnum;

/**
 * @功能说明：
 * @公司名称：首都信息发展股份有限公司
 * @作者：zhaochun
 * @创建时间：2015-06-08
 */
public interface UserService {

    public UserGeneralInfo add(String name, String password,UserTypeEnum userType);

    public UserGeneralInfo add(UserGeneralInfo userGeneralInfo);

    public int fetch(String username, String password);

    public void updatePassword(int userId, String password);

    public boolean updateRegisterCheckState(int userId, int rc);

}
